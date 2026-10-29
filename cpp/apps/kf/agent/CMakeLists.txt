# KernForge executable: agent
add_executable(agent main.cpp)
set_target_properties(agent PROPERTIES OUTPUT_NAME "agent")
target_include_directories(agent PRIVATE "${PROJECT_SOURCE_DIR}/include")
target_link_libraries(agent PRIVATE common)
