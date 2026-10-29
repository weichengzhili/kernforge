# KernForge executable: probe
add_executable(probe main.cpp)
set_target_properties(probe PROPERTIES OUTPUT_NAME "probe")
target_include_directories(probe PRIVATE "${PROJECT_SOURCE_DIR}/include")
target_link_libraries(probe PRIVATE common)
