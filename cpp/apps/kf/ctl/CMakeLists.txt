# KernForge executable: kfctl
add_executable(kfctl main.cpp)
set_target_properties(kfctl PROPERTIES OUTPUT_NAME "kfctl")
target_include_directories(kfctl PRIVATE "${PROJECT_SOURCE_DIR}/include")
target_link_libraries(kfctl PRIVATE common)
