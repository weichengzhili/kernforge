# KernForge executable: supervisord
add_executable(supervisord main.cpp)
set_target_properties(supervisord PROPERTIES OUTPUT_NAME "supervisord")
target_include_directories(supervisord PRIVATE "${PROJECT_SOURCE_DIR}/include")
target_link_libraries(supervisord PRIVATE common)
