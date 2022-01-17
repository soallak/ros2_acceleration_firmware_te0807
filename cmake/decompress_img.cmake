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
# decompress firmware raw "sd_card.img.tar.gz" image
message(STATUS "Decompressing " ${FIRMWARE_DIR} "/sd_card.img.tar.gz")

set(CMD "tar -xzf ${FIRMWARE_DIR}/sd_card.img.tar.gz -C ${FIRMWARE_DIR}")
run("${TESTFIRMWARE} ${CMD}")
