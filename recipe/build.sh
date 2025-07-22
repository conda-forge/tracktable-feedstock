# Build Linux or MacOS package from tracktable source
HERE=${PWD}
mkdir build
mkdir install

cd build
cmake ${CMAKE_ARGS} \
        -D CMAKE_BUILD_TYPE=Release \
        -D BUILD_DOCUMENTATION=OFF \
        -D Python3_EXECUTABLE:FILEPATH=${PYTHON} \
        -D Python3_ROOT_DIR:PATH=${PREFIX} \
        -D CMAKE_INSTALL_PREFIX:PATH=${HERE}/install \
        -D BUILD_TESTING=OFF \
        -D BUILD_EXAMPLES=OFF \
        -D CMAKE_CXX_FLAGS="-D_LIBCPP_DISABLE_AVAILABILITY" \
        $SRC_DIR
make -j${CPU_COUNT}
make install
cd ${HERE}/install
${PYTHON} -m pip install --no-deps .
