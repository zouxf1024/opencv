#! /bin/bash

TOP_DIR=$(pwd)
OUT_SYSTEM_DIR=$TOP_DIR/out/system
EXTRA_MODULE_PATH=$TOP_DIR/../opencv_contrib/modules/
CLEAN_CMD=cleanthen

[ -d $OUT_SYSTEM_DIR ] && rm -rf $OUT_SYSTEM_DIR && mkdir $OUT_SYSTEM_DIR

logfile="/dev/null"
check_cmd(){
    "$@" >> $logfile 2>&1
}
check_cc(){
  check_cmd arm-linux-gnueabihf-gcc -v
}
check_cc
if [ $? -eq 127 ];then
        export PATH=$PATH:$TOP_DIR/prebuilts/toolschain/bin
fi

# call cmake first
export SDK_ROOT="$(pwd)"
CMAKE_VERSION=$(cmake --version 2>/dev/null | grep "cmake version")
if [ "$CMAKE_VERSION" = "" ];then
echo "Error: cannot find cmake."
echo "You should install cmake at first as follows:"
echo "sudo apt-get install cmake"
exit
fi

rm -rf release && mkdir release 2>/dev/null
cd release
cmake -DENABLE_NEON=ON \
      -DBUILD_opencv_ts=OFF -DBUILD_TESTS=OFF -DBUILD_PERF_TESTS=OFF \
      -DBUILD_ZLIB=ON -DBUILD_TIFF=ON -DBUILD_JASPER=ON -DBUILD_JPEG=ON -DBUILD_PNG=ON \
      -DBUILD_SHARED_LIBS=OFF \
      -DCMAKE_BUILD_TYPE=RELEASE \
      -DOPENCV_EXTRA_MODULES_PATH=$EXTRA_MODULE_PATH \
      -DCMAKE_INSTALL_PREFIX=$OUT_SYSTEM_DIR \
      -DCMAKE_TOOLCHAIN_FILE=$SDK_ROOT/platforms/linux/rk3288.toolchain.cmake \
      ..



      # -DBUILD_OPENEXR=ON \
#make -j4 && make install
#cd ..

