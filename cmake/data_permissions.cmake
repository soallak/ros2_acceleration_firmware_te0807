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
# adds execution capabilities to the firmware/data folder

set(CMD "${TESTFIRMWARE} chmod -R +x ${FIRMWARE_DIR}/data")
execute_process(COMMAND bash -c ${CMD})
