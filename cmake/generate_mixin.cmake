#    ____  ____
#   /   /\/   /
#  /___/  \  /   Copyright (c) 2021, Xilinx®.
#  \   \   \/    Author: Víctor Mayoral Vilches <victorma@xilinx.com>
#   \   \
#   /   /
#  /___/   /\
#  \   \  /  \
#   \___\/\___\
#
# generate and add mixins at build-time to further simplify embedded flows
#
# NOTE: this logic is specific this this branch (which represent the board supported)

message(STATUS "Creating mixins for the overlay ROS 2 workspace")

set(TEMPLATE_MIXIN "${CMAKE_BINARY_DIR}/te0807.mixin.template")
set(TEMPLATE_YAML "${CMAKE_BINARY_DIR}/index.yaml.template")
set(TEMPLATE_TOOLCHAIN "${CMAKE_BINARY_DIR}/toolchain.cmake")
set(MIXIN_DIR "${FIRMWARE_DIR}/mixin")
set(MIXIN "${MIXIN_DIR}/te0807.mixin")
set(INDEX_YAML "${MIXIN_DIR}/index.yaml")
set(TOOLCHAIN "${MIXIN_DIR}/toolchain.cmake")

# arguments
# - ARG1_*: firmware directory, resulting toolchain should be here
# - ARG2_*: vitis directory, refer to "xilinx_vitis" package for details
# - ARG3_*: root of the install directory
set(ARG1_FIRMWARE_DIR ${FIRMWARE_DIR})

if(DEFINED ENV{XILINX_VITIS})
    set(ARG2_VITIS_DIR $ENV{XILINX_VITIS})
else()
  message(FATAL_ERROR "XILINX_VITIS environement variable is not set")
endif()

# deploy in firmware
run("${TESTFIRMWARE} mkdir -p ${MIXIN_DIR}")
run("${TESTFIRMWARE} mv ${TEMPLATE_MIXIN} ${MIXIN}")
run("${TESTFIRMWARE} mv ${TEMPLATE_YAML} ${INDEX_YAML}")
run("${TESTFIRMWARE} mv ${TEMPLATE_TOOLCHAIN} ${TOOLCHAIN}")
# replace placeholders
set(SEDEXP_ARG1 "s:__FIRMWARE_DIR__:${ARG1_FIRMWARE_DIR}:g")
set(SEDEXP_ARG2 "s:__VITIS_DIR__:${ARG2_VITIS_DIR}:g")
set(SEDEXP_ARG3 "s:__TOOLCHAIN_DIR__:${MIXIN_DIR}:g")
set(SEDEXP_ARG4 "s:__INSTALL_DIR__:${CMAKE_INSTALL_PREFIX}:g")
run("${TESTFIRMWARE} sed -i ${SEDEXP_ARG1} ${TOOLCHAIN}")
run("${TESTFIRMWARE} sed -i ${SEDEXP_ARG2} ${TOOLCHAIN}")
run("${TESTFIRMWARE} sed -i ${SEDEXP_ARG4} ${TOOLCHAIN}")
run("${TESTFIRMWARE} sed -i ${SEDEXP_ARG3} ${MIXIN}")

# enable mixins
run("${TESTFIRMWARE} colcon mixin remove te0807 2> /dev/null")  # clean up prior stuff
set(ADD_MIXIN_PATH "file://${FIRMWARE_DIR}/mixin/index.yaml")
run("${TESTFIRMWARE} colcon mixin add te0807 ${ADD_MIXIN_PATH}")
# message("ADD_MIXIN_PATH: " ${ADD_MIXIN_PATH})
run("${TESTFIRMWARE} colcon mixin update te0807")
