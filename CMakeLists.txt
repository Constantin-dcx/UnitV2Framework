## SELECT TARGET ##
# Get a list of all .cpp files in the main folder
file(GLOB CPP_FILES "main/*.cpp")

# Extract target names from file names (remove .cpp extension)
foreach(CPP_FILE ${CPP_FILES})
    get_filename_component(TARGET_NAME ${CPP_FILE} NAME_WE)
    list(APPEND VALID_TARGETS ${TARGET_NAME})
endforeach()

# Check if the TARGET variable is provided
if(NOT TARGET)
    message(FATAL_ERROR "TARGET variable is required. Please provide a target using -DTARGET=<target_name>")
endif()

# Check if the provided TARGET is in the list of valid targets
list(FIND VALID_TARGETS ${TARGET} TARGET_INDEX)
if(${TARGET_INDEX} EQUAL -1)
    message(FATAL_ERROR "Invalid TARGET. Please provide a valid target from the list: ${VALID_TARGETS}")
endif()

message(STATUS "Selected target: ${TARGET}")


# set compiler
set(ARM_TOOLCHAIN_PATH "${CMAKE_CURRENT_LIST_DIR}/gcc-arm-10.2-2020.11-x86_64-arm-none-linux-gnueabihf")
set(CMAKE_CXX_COMPILER "${ARM_TOOLCHAIN_PATH}/bin/arm-none-linux-gnueabihf-g++")
set(CMAKE_C_COMPILER "${ARM_TOOLCHAIN_PATH}/bin/arm-none-linux-gnueabihf-gcc")

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

SET(CMAKE_BUILD_TYPE "Debug")
SET(CMAKE_CXX_FLAGS_DEBUG "$ENV{CXXFLAGS} -O0 -Wall -g2 -ggdb")
SET(CMAKE_CXX_FLAGS_RELEASE "$ENV{CXXFLAGS} -O3 -Wall")
# project name
PROJECT(${TARGET})
# requirement of cmake version
cmake_minimum_required(VERSION 3.5)

# set the directory of executable files
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/bin)
set(OpenCV_DIR "${CMAKE_CURRENT_LIST_DIR}/opencv/build")

# find required opencv
find_package(OpenCV REQUIRED)
# directory of opencv headers
include_directories(${OpenCV_INCLUDE_DIRS})
# name of executable file and path of source file
add_executable(${TARGET} main/${TARGET}.cpp)
# directory of opencv library
link_directories(${OpenCV_LIBRARY_DIRS})
# opencv libraries
target_link_libraries(${TARGET} ${OpenCV_LIBS})

# includes
include_directories(${PROJECT_SOURCE_DIR}/include)
include_directories(${PROJECT_SOURCE_DIR}/include/ncnn)
target_link_libraries (${TARGET} ${PROJECT_SOURCE_DIR}/lib/libncnn.a -fopenmp)

# .so link
target_link_libraries (${TARGET} ${PROJECT_SOURCE_DIR}/lib/libzbar.so)

FILE(GLOB_RECURSE PRJ_SRC
        "${PROJECT_SOURCE_DIR}/src/*.c"
        "${PROJECT_SOURCE_DIR}/src/*.cpp"
        )

add_library(mainlib ${PRJ_SRC})

target_link_libraries (mainlib ${PROJECT_SOURCE_DIR}/lib/libncnn.a -fopenmp)

target_link_libraries(${TARGET} mainlib)
