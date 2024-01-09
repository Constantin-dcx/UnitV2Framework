set(ARM_TOOLCHAIN_PATH "${CMAKE_CURRENT_LIST_DIR}/gcc-arm-10.2-2020.11-x86_64-arm-none-linux-gnueabihf")

set(CMAKE_C_COMPILER "${ARM_TOOLCHAIN_PATH}/bin/arm-none-linux-gnueabihf-gcc")
set(CMAKE_CXX_COMPILER "${ARM_TOOLCHAIN_PATH}/bin/arm-none-linux-gnueabihf-g++")

# Include the existing OpenCV toolchain file
include("${CMAKE_CURRENT_LIST_DIR}/opencv/platforms/linux/arm-gnueabi.toolchain.cmake")
