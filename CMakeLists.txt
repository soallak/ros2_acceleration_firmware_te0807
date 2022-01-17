cmake_minimum_required(VERSION 3.5)
project(acceleration_firmware_te0807)

find_package(ament_cmake REQUIRED)
include(cmake/firmware_setup.cmake)  # This script is what defines the install firmware script

# install firmware  if not already done
if (NOT EXISTS ${FIRMWARE_DIR})
  install(
    DIRECTORY
      firmware/
    DESTINATION
      ${FIRMWARE_DIR}
  )
endif()  # NOT EXISTS ${FIRMWARE_DIR}

install(SCRIPT "${CMAKE_SOURCE_DIR}/cmake/firmware_setup.cmake")

## Generate toolchain, first install template, then execute
install(
  FILES
    "${CMAKE_SOURCE_DIR}/scripts/te0807.mixin.template"
    "${CMAKE_SOURCE_DIR}/scripts/index.yaml.template"
    "${CMAKE_SOURCE_DIR}/cmake/toolchain.cmake"
  DESTINATION
    ${CMAKE_BINARY_DIR}
)


install(SCRIPT "${CMAKE_SOURCE_DIR}/cmake/generate_mixin.cmake")

# I don't understand why this is needed
install(SCRIPT "${CMAKE_SOURCE_DIR}/cmake/colcon_ignore.cmake")


# kept so that other packages can depend on it
ament_package()
