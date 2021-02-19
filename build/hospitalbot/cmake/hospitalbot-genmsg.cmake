# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "hospitalbot: 4 messages, 0 services")

set(MSG_I_FLAGS "-Ihospitalbot:/home/darkboy/catkin_ws/src/hospitalbot/msg;-Istd_msgs:/opt/ros/kinetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(hospitalbot_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/darkboy/catkin_ws/src/hospitalbot/msg/Motor.msg" NAME_WE)
add_custom_target(_hospitalbot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "hospitalbot" "/home/darkboy/catkin_ws/src/hospitalbot/msg/Motor.msg" ""
)

get_filename_component(_filename "/home/darkboy/catkin_ws/src/hospitalbot/msg/Battery.msg" NAME_WE)
add_custom_target(_hospitalbot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "hospitalbot" "/home/darkboy/catkin_ws/src/hospitalbot/msg/Battery.msg" ""
)

get_filename_component(_filename "/home/darkboy/catkin_ws/src/hospitalbot/msg/RobotState.msg" NAME_WE)
add_custom_target(_hospitalbot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "hospitalbot" "/home/darkboy/catkin_ws/src/hospitalbot/msg/RobotState.msg" ""
)

get_filename_component(_filename "/home/darkboy/catkin_ws/src/hospitalbot/msg/Communication.msg" NAME_WE)
add_custom_target(_hospitalbot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "hospitalbot" "/home/darkboy/catkin_ws/src/hospitalbot/msg/Communication.msg" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(hospitalbot
  "/home/darkboy/catkin_ws/src/hospitalbot/msg/Motor.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/hospitalbot
)
_generate_msg_cpp(hospitalbot
  "/home/darkboy/catkin_ws/src/hospitalbot/msg/Battery.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/hospitalbot
)
_generate_msg_cpp(hospitalbot
  "/home/darkboy/catkin_ws/src/hospitalbot/msg/RobotState.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/hospitalbot
)
_generate_msg_cpp(hospitalbot
  "/home/darkboy/catkin_ws/src/hospitalbot/msg/Communication.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/hospitalbot
)

### Generating Services

### Generating Module File
_generate_module_cpp(hospitalbot
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/hospitalbot
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(hospitalbot_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(hospitalbot_generate_messages hospitalbot_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/darkboy/catkin_ws/src/hospitalbot/msg/Motor.msg" NAME_WE)
add_dependencies(hospitalbot_generate_messages_cpp _hospitalbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/darkboy/catkin_ws/src/hospitalbot/msg/Battery.msg" NAME_WE)
add_dependencies(hospitalbot_generate_messages_cpp _hospitalbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/darkboy/catkin_ws/src/hospitalbot/msg/RobotState.msg" NAME_WE)
add_dependencies(hospitalbot_generate_messages_cpp _hospitalbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/darkboy/catkin_ws/src/hospitalbot/msg/Communication.msg" NAME_WE)
add_dependencies(hospitalbot_generate_messages_cpp _hospitalbot_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(hospitalbot_gencpp)
add_dependencies(hospitalbot_gencpp hospitalbot_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS hospitalbot_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(hospitalbot
  "/home/darkboy/catkin_ws/src/hospitalbot/msg/Motor.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/hospitalbot
)
_generate_msg_eus(hospitalbot
  "/home/darkboy/catkin_ws/src/hospitalbot/msg/Battery.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/hospitalbot
)
_generate_msg_eus(hospitalbot
  "/home/darkboy/catkin_ws/src/hospitalbot/msg/RobotState.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/hospitalbot
)
_generate_msg_eus(hospitalbot
  "/home/darkboy/catkin_ws/src/hospitalbot/msg/Communication.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/hospitalbot
)

### Generating Services

### Generating Module File
_generate_module_eus(hospitalbot
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/hospitalbot
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(hospitalbot_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(hospitalbot_generate_messages hospitalbot_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/darkboy/catkin_ws/src/hospitalbot/msg/Motor.msg" NAME_WE)
add_dependencies(hospitalbot_generate_messages_eus _hospitalbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/darkboy/catkin_ws/src/hospitalbot/msg/Battery.msg" NAME_WE)
add_dependencies(hospitalbot_generate_messages_eus _hospitalbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/darkboy/catkin_ws/src/hospitalbot/msg/RobotState.msg" NAME_WE)
add_dependencies(hospitalbot_generate_messages_eus _hospitalbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/darkboy/catkin_ws/src/hospitalbot/msg/Communication.msg" NAME_WE)
add_dependencies(hospitalbot_generate_messages_eus _hospitalbot_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(hospitalbot_geneus)
add_dependencies(hospitalbot_geneus hospitalbot_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS hospitalbot_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(hospitalbot
  "/home/darkboy/catkin_ws/src/hospitalbot/msg/Motor.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/hospitalbot
)
_generate_msg_lisp(hospitalbot
  "/home/darkboy/catkin_ws/src/hospitalbot/msg/Battery.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/hospitalbot
)
_generate_msg_lisp(hospitalbot
  "/home/darkboy/catkin_ws/src/hospitalbot/msg/RobotState.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/hospitalbot
)
_generate_msg_lisp(hospitalbot
  "/home/darkboy/catkin_ws/src/hospitalbot/msg/Communication.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/hospitalbot
)

### Generating Services

### Generating Module File
_generate_module_lisp(hospitalbot
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/hospitalbot
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(hospitalbot_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(hospitalbot_generate_messages hospitalbot_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/darkboy/catkin_ws/src/hospitalbot/msg/Motor.msg" NAME_WE)
add_dependencies(hospitalbot_generate_messages_lisp _hospitalbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/darkboy/catkin_ws/src/hospitalbot/msg/Battery.msg" NAME_WE)
add_dependencies(hospitalbot_generate_messages_lisp _hospitalbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/darkboy/catkin_ws/src/hospitalbot/msg/RobotState.msg" NAME_WE)
add_dependencies(hospitalbot_generate_messages_lisp _hospitalbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/darkboy/catkin_ws/src/hospitalbot/msg/Communication.msg" NAME_WE)
add_dependencies(hospitalbot_generate_messages_lisp _hospitalbot_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(hospitalbot_genlisp)
add_dependencies(hospitalbot_genlisp hospitalbot_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS hospitalbot_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(hospitalbot
  "/home/darkboy/catkin_ws/src/hospitalbot/msg/Motor.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/hospitalbot
)
_generate_msg_nodejs(hospitalbot
  "/home/darkboy/catkin_ws/src/hospitalbot/msg/Battery.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/hospitalbot
)
_generate_msg_nodejs(hospitalbot
  "/home/darkboy/catkin_ws/src/hospitalbot/msg/RobotState.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/hospitalbot
)
_generate_msg_nodejs(hospitalbot
  "/home/darkboy/catkin_ws/src/hospitalbot/msg/Communication.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/hospitalbot
)

### Generating Services

### Generating Module File
_generate_module_nodejs(hospitalbot
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/hospitalbot
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(hospitalbot_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(hospitalbot_generate_messages hospitalbot_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/darkboy/catkin_ws/src/hospitalbot/msg/Motor.msg" NAME_WE)
add_dependencies(hospitalbot_generate_messages_nodejs _hospitalbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/darkboy/catkin_ws/src/hospitalbot/msg/Battery.msg" NAME_WE)
add_dependencies(hospitalbot_generate_messages_nodejs _hospitalbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/darkboy/catkin_ws/src/hospitalbot/msg/RobotState.msg" NAME_WE)
add_dependencies(hospitalbot_generate_messages_nodejs _hospitalbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/darkboy/catkin_ws/src/hospitalbot/msg/Communication.msg" NAME_WE)
add_dependencies(hospitalbot_generate_messages_nodejs _hospitalbot_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(hospitalbot_gennodejs)
add_dependencies(hospitalbot_gennodejs hospitalbot_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS hospitalbot_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(hospitalbot
  "/home/darkboy/catkin_ws/src/hospitalbot/msg/Motor.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/hospitalbot
)
_generate_msg_py(hospitalbot
  "/home/darkboy/catkin_ws/src/hospitalbot/msg/Battery.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/hospitalbot
)
_generate_msg_py(hospitalbot
  "/home/darkboy/catkin_ws/src/hospitalbot/msg/RobotState.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/hospitalbot
)
_generate_msg_py(hospitalbot
  "/home/darkboy/catkin_ws/src/hospitalbot/msg/Communication.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/hospitalbot
)

### Generating Services

### Generating Module File
_generate_module_py(hospitalbot
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/hospitalbot
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(hospitalbot_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(hospitalbot_generate_messages hospitalbot_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/darkboy/catkin_ws/src/hospitalbot/msg/Motor.msg" NAME_WE)
add_dependencies(hospitalbot_generate_messages_py _hospitalbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/darkboy/catkin_ws/src/hospitalbot/msg/Battery.msg" NAME_WE)
add_dependencies(hospitalbot_generate_messages_py _hospitalbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/darkboy/catkin_ws/src/hospitalbot/msg/RobotState.msg" NAME_WE)
add_dependencies(hospitalbot_generate_messages_py _hospitalbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/darkboy/catkin_ws/src/hospitalbot/msg/Communication.msg" NAME_WE)
add_dependencies(hospitalbot_generate_messages_py _hospitalbot_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(hospitalbot_genpy)
add_dependencies(hospitalbot_genpy hospitalbot_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS hospitalbot_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/hospitalbot)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/hospitalbot
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(hospitalbot_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/hospitalbot)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/hospitalbot
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(hospitalbot_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/hospitalbot)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/hospitalbot
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(hospitalbot_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/hospitalbot)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/hospitalbot
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(hospitalbot_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/hospitalbot)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/hospitalbot\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/hospitalbot
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(hospitalbot_generate_messages_py std_msgs_generate_messages_py)
endif()
