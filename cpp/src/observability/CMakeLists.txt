# KernForge / observability
# LLVM convention: one CMakeLists.txt per module directory.
# Source discovery is GLOB_RECURSE during bootstrap; replace with an
# explicit target_sources list once the module stabilizes (LLVM policy).
file(GLOB_RECURSE OBSERVABILITY_SOURCES CONFIGURE_DEPENDS
    "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp"
)

add_library(observability STATIC ${OBSERVABILITY_SOURCES})

target_include_directories(observability
    PUBLIC  "${PROJECT_SOURCE_DIR}/include"
    PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}"
)

target_link_libraries(observability PUBLIC common)

# FIXED #5: strict warnings are now actually applied to every module.
enable_warnings(observability)
