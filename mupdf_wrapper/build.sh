#! /bin/sh

set -e

CC=${CC:-gcc}
AR=${AR:-ar}

echo
echo "CC: $CC"
echo "AR: $AR"

TARGET_OS=${TARGET_OS:-$(uname -s)}

echo
echo "TARGET_OS: $TARGET_OS"

BUILD_DIR=../target/mupdf_wrapper/${TARGET_OS}
mkdir -p $BUILD_DIR
$CC $CPPFLAGS $CFLAGS -I../thirdparty/mupdf/include -c mupdf_wrapper.c -o ${BUILD_DIR}/mupdf_wrapper.o

echo
echo "CPPFLAGS: $CPPFLAGS"
echo "CFLAGS: $CFLAGS"
echo "$CC $CPPFLAGS $CFLAGS -I../thirdparty/mupdf/include -c mupdf_wrapper.c -o ${BUILD_DIR}/mupdf_wrapper.o"

$AR -rcs ${BUILD_DIR}/libmupdf_wrapper.a ${BUILD_DIR}/mupdf_wrapper.o

echo
echo "$AR -rcs ${BUILD_DIR}/libmupdf_wrapper.a ${BUILD_DIR}/mupdf_wrapper.o"
