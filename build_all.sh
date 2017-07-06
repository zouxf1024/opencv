#! /bin/bash

TOP_DIR=$(pwd)
OUT_SYSTEM_DIR=$TOP_DIR/out/system
EXTRA_MODULE_PATH=$TOP_DIR/../opencv_contrib/modules/
CLEAN_CMD=cleanthen

[ -d $OUT_SYSTEM_DIR ] && rm -rf $OUT_SYSTEM_DIR && mkdir -p $OUT_SYSTEM_DIR

rm -rf release && mkdir release 2>/dev/null
cd release
cmake -DCMAKE_BUILD_TYPE=RELEASE \
      -DOPENCV_EXTRA_MODULES_PATH=$EXTRA_MODULE_PATH \
      -DCMAKE_INSTALL_PREFIX=/usr/local/ \
      -DBUILD_opencv_nonfree=ON \
      ..



