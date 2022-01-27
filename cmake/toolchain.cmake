SET(CMAKE_SYSTEM_NAME Linux)
SET(CMAKE_SYSTEM_VERSION 1)
SET(CMAKE_SYSTEM_PROCESSOR aarch64)
SET(CMAKE_VERBOSE_MAKEFILE:BOOL ON)  # pushed to here, instead of as within --cmake-args

SET(FIRMWARE_DIR __FIRMWARE_DIR__)
SET(VITIS_DIR __VITIS_DIR__)
SET(INSTALL_DIR __INSTALL_DIR__)

# Specify the cross compiler
SET(COMPILER_PREFIX ${VITIS_DIR}/gnu/aarch64/lin/aarch64-linux/bin/)
SET(CMAKE_C_COMPILER ${COMPILER_PREFIX}/aarch64-linux-gnu-gcc)
SET(CMAKE_CXX_COMPILER ${COMPILER_PREFIX}/aarch64-linux-gnu-g++)

# Specify the target file system
SET(CMAKE_SYSROOT ${FIRMWARE_DIR}/sysroot)
SET(CMAKE_FIND_ROOT_PATH "${INSTALL_DIR}-te0807" ${CMAKE_SYSROOT} ${CMAKE_SYSROOT}/opt/ros/rolling/)

SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
SET(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

# This is not detected automtically by Vitis, somehow
INCLUDE_DIRECTORIES(BEFORE SYSTEM ${CMAKE_SYSROOT}/usr/include/aarch64-linux-gnu/)

# for the same reason, i do this manually
SET(LINKER_FLAGS_INIT "-Wl,--allow-shlib-undefined --sysroot=${CMAKE_SYSROOT} -L${CMAKE_SYSROOT}/lib -L${CMAKE_SYSROOT}/usr/lib/ -L${CMAKE_SYSROOT}/usr/lib/aarch64-linux-gnu -L${CMAKE_SYSROOT}/usr/lib/gcc/aarch64-linux-gnu/9/ -L${CMAKE_SYSROOT}/lib/aarch64-linux-gnu -Wl,-rpath-link=${CMAKE_SYSROOT}/usr/lib/aarch64-linux-gnu,-rpath-link=${CMAKE_SYSROOT}/usr/lib,-rpath-link=${CMAKE_SYSROOT}/lib/aarch64-linux-gnu,-rpath-link=${CMAKE_SYSROOT}/usr/lib/gcc/aarch64-linux-gnu/9/")
SET(CMAKE_SHARED_LINKER_FLAGS_INIT ${LINKER_FLAGS_INIT})
SET(CMAKE_EXE_LINKER_FLAGS_INIT ${LINKER_FLAGS_INIT})

# to fix FindThread 
SET(CMAKE_THREAD_LIBS_INIT "-lpthread")
SET(CMAKE_HAVE_THREADS_LIBRARY 1)
SET(CMAKE_USE_WIN32_THREADS_INIT 0)
SET(CMAKE_USE_PTHREADS_INIT 1)
SET(THREADS_PREFER_PTHREAD_FLAG ON)

