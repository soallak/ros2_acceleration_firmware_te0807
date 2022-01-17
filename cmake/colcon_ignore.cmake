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
# create COLCON_IGNORE file for the firmware directory

# message("Adding COLCON_IGNORE to firmware")  # debug
set(CMD "${TESTFIRMWARE} touch ${FIRMWARE_DIR}/COLCON_IGNORE")
execute_process(COMMAND bash -c ${CMD})
