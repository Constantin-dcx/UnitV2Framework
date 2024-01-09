# UnitV2Framework

## Install

### Toolchain

Download and extract `arm-none-linux-gnueabihf` toolchain:

```bash
cd UnitV2Framework
curl -LO https://developer.arm.com/-/media/Files/downloads/gnu-a/10.2-2020.11/binrel/gcc-arm-10.2-2020.11-x86_64-arm-none-linux-gnueabihf.tar.xz
tar Jxfv gcc-arm-10.2-2020.11-x86_64-arm-none-linux-gnueabihf.tar.xz
```

### OpenCV

Clone [OpenCV](https://github.com/opencv/opencv) and [OpenCV's extra modules](https://github.com/opencv/opencv_contrib) repositories:

```bash
cd UnitV2Framework
git clone git@github.com:opencv/opencv.git -b 4.4.0 --depth 1 
git clone git@github.com:opencv/opencv_contrib.git -b 4.4.0 --depth 1 
```

Cross-compile OpenCV for UnitV2

```bash
cd opencv
mkdir build && cd build
cmake -DCMAKE_TOOLCHAIN_FILE=../../my-arm-toolchain.cmake -DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules -DBUILD_LIST=tracking,imgcodecs,videoio,highgui,features2d,ml,xfeatures2d -DCMAKE_BUILD_TYPE=Release ..
cmake --build .
make install
```

## Usage

Compile the binary you want with cmake. Here is an example for building ***object_recognition***:

```bash
cd UnitV2Framework
mkdir build && cd build
cmake -DTARGET=object_recognition ..  # replace with the binary you want to compile
cmake --build .
```

You can then copy the new binary to the UnitV2 via ssh:

```bash
scp /path/to/UnitV2Framework/bin/object_recognition root@UNITV2_IP_ADDRESS:/home/m5stack/payload/bin/object_recognition
```
