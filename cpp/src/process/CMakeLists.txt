# KernForge / process
# LLVM convention: one CMakeLists.txt per module directory.
# Source discovery is GLOB_RECURSE during bootstrap; replace with an
# explicit target_sources list once the module stabilizes (LLVM policy).
file(GLOB_RECURSE PROCESS_SOURCES CONFIGURE_DEPENDS
    "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp"
)

add_library(process STATIC ${PROCESS_SOURCES})

target_include_directories(process
    PUBLIC  "${PROJECT_SOURCE_DIR}/include"
    PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}"
)

target_link_libraries(process PUBLIC common)

# FIXED #5: strict warnings are now actually applied to every module.
enable_warnings(process)
