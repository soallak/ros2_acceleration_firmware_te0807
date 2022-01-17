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
# Set up the firmware variables for this cmake level and define macros

set(FIRMWARE_DIR ${CMAKE_INSTALL_PREFIX}/../acceleration/firmware/kv260)  # <ws>/acceleration/firmware/kv260

# definition to automate testing of a fully deployed
# vitis. The condition used is the last step of the .cmake
# scripts: the creation of the COLCON_IGNORE file.
set(TESTFIRMWARE "test -e ${FIRMWARE_DIR}/COLCON_IGNORE || ")

# run() macro
#  runs the CMD passed as an argument
macro(run CMD)
  execute_process(COMMAND bash -c ${CMD})
endmacro()
