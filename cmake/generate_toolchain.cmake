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
# generate a toolchain for cross-compilation
#
# NOTE: this logic is specific this this branch (which represent the board supported)

set(TEMPLATE "${CMAKE_BINARY_DIR}/generate_toolchain.template.sh")
set(SCRIPT "${CMAKE_BINARY_DIR}/generate_toolchain.sh")

# arguments
# - ARG1_*: firmware directory, resulting toolchain should be here
# - ARG2_*: vitis directory, refer to "xilinx_vitis" package for details
# - ARG3_*: root of the install directory
set(ARG1_FIRMWARE_DIR ${FIRMWARE_DIR})
set(ARG2_VITIS_DIR ${FIRMWARE_DIR}/../vitis)
set(ARG3_INSTALL_DIR ${CMAKE_INSTALL_PREFIX})

message(STATUS "ARG1_FIRMWARE_DIR: " ${ARG1_FIRMWARE_DIR})
message(STATUS "ARG2_VITIS_DIR: " ${ARG2_VITIS_DIR})
message(STATUS "ARG3_INSTALL_DIR: " ${ARG3_INSTALL_DIR})

execute_process(COMMAND ${TESTFIRMWARE} mv ${TEMPLATE} ${SCRIPT})
execute_process(COMMAND ${TESTFIRMWARE} chmod +x ${SCRIPT})
execute_process(
    COMMAND 
    ${TESTFIRMWARE} ${SCRIPT} ${ARG1_FIRMWARE_DIR} ${ARG2_VITIS_DIR} ${ARG3_INSTALL_DIR}
    RESULT_VARIABLE 
        CMD_ERROR
)
message(STATUS "CMD_ERROR:" ${CMD_ERROR})
