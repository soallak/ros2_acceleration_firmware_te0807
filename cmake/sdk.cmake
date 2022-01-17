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
# create install SDK, deploy sysroot and apply fixes
message(STATUS "Starting with SDK deployment")

set(TARGET_SYSROOT_DIR ${FIRMWARE_DIR}/sysroots/aarch64-xilinx-linux)

# install the Yocto SDK
run("${TESTFIRMWARE} chmod +x ${FIRMWARE_DIR}/sdk.sh")
run("${TESTFIRMWARE} ${FIRMWARE_DIR}/sdk.sh -d ${FIRMWARE_DIR} -y")

# # FIXME, Absolute paths in cmake file created by rcl_yaml_param_parser
# # see https://gitlab.com/xilinxrobotics/docs/-/issues/14
message(STATUS "FIX: Fixing issue with rcl_yaml_param_parser.")

execute_process(
    COMMAND
        sed -i "s:;/home/xilinx/xilinx-k26-starterkit-2020.2.2/build/tmp/work/aarch64-xilinx-linux/rcl-yaml-param-parser/1.1.5-1-r0/recipe-sysroot/usr/lib/libyaml.so::"
            ${TARGET_SYSROOT_DIR}/usr/share/rcl_yaml_param_parser/cmake/rcl_yaml_param_parserExport.cmake
)

# # FIXME, CMake configuration issues with libfoonathan_memory
# # see https://gitlab.com/xilinxrobotics/docs/-/issues/15
# echo "FIX: Manually deploying libfoonathan_memory."
# cp lib/libfoonathan_memory-0.6.2.a $target_sysroot_dir/usr/lib/
message(STATUS "FIX: Manually deploying libfoonathan_memory")
run("${TESTFIRMWARE} cp ${FIRMWARE_DIR}/lib/libfoonathan_memory-0.6.2.a ${TARGET_SYSROOT_DIR}/usr/lib/")
# execute_process(
#     COMMAND
#         ${TESTFIRMWARE} cp ${FIRMWARE_DIR}/lib/libfoonathan_memory-0.6.2.a ${TARGET_SYSROOT_DIR}/usr/lib/
# )

# # FIXME, Absolute paths in cmake file created by fastrtps-targets
# # see https://gitlab.com/xilinxrobotics/docs/-/issues/16
# sed -i 's\;/media/erle/hd/xilinx-zcu102-2020.2-ros/build/tmp/work/aarch64-xilinx-linux/fastrtps/2.0.0-3-r0/recipe-sysroot/usr/lib/libtinyxml2.so\\' $target_sysroot_dir/usr/share/fastrtps/cmake/fastrtps-targets.cmake
message(STATUS "FIXME, Absolute paths in cmake file created by fastrtps-targets.")
execute_process(
    COMMAND
        sed -i "s:;/home/xilinx/xilinx-k26-starterkit-2020.2.2/build/tmp/work/aarch64-xilinx-linux/fastrtps/2.0.0-3-r0/recipe-sysroot/usr/lib/libtinyxml2.so::"
            ${TARGET_SYSROOT_DIR}/usr/share/fastrtps/cmake/fastrtps-targets.cmake

)

# # FIXME, Copy libstdc++fs.a
# # see https://gitlab.com/xilinxrobotics/docs/-/issues/39#note_664125180
message(STATUS "FIXME, copy libstdc++fs.a.")
run("${TESTFIRMWARE} cp ${FIRMWARE_DIR}/lib/libstdc++fs.a ${TARGET_SYSROOT_DIR}/usr/lib/")

message(STATUS "SDK setup done.")
