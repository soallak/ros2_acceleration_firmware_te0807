set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR aarch64)
set(CMAKE_VERBOSE_MAKEFILE:BOOL ON)  # pushed to here, instead of as within --cmake-args

set(FIRMWARE_DIR __FIRMWARE_DIR__)
set(VITIS_DIR __VITIS_DIR__)

# Specify the cross compiler
set(CMAKE_C_COMPILER ${VITIS_DIR}/gnu/aarch64/lin/aarch64-linux/bin/aarch64-linux-gnu-gcc)
set(CMAKE_CXX_COMPILER ${VITIS_DIR}/gnu/aarch64/lin/aarch64-linux/bin/aarch64-linux-gnu-g++)

# Specify the target file system
set(CMAKE_SYSROOT ${FIRMWARE_DIR}/sysroot)
set(CMAKE_FIND_ROOT_PATH ${CMAKE_SYSROOT} ${CMAKE_SYSROOT}/opt/ros/rolling/)

set(CMAKE_INSTALL_RPATH 
	${CMAKE_SYSROOT}/usr/lib
   )
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

# Specify the python SOABI
set(PYTHON_SOABI cpython-37m-aarch64-linux-gnu)

# This assumes that pthread will be available on the target system
# (this emulates that the return of the TRY_RUN is a return code "0")
set(THREADS_PTHREAD_ARG "0"
  CACHE STRING "Result from TRY_RUN" FORCE)
