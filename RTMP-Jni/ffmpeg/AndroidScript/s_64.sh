#!/bin/bash
NDK=/opt/android-ndk-r10e
mkdir -p build/android/arm64

cp -rf /home/eoollo/SVN/AppStreaming/ffmpeg/ffmpeg-2.8.2/ build/arm64
cd build/arm64

SYSROOT=$NDK/platforms/android-21/arch-arm64/
TOOLCHAIN=$NDK/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64

function build_arm64
{
	./configure \
		--disable-all \
		--enable-cross-compile \
		--enable-pthreads \
		--enable-shared \
		--enable-static \
		--enable-avutil \
		--enable-swscale \
		--enable-avfilter \
		--enable-swresample \
		--enable-network \
		--enable-decoder=png \
		--enable-decoder=jpeg \
		--enable-decoder=x264 \
		--enable-decoder=aac \
		\
		--prefix=../../build/android/arm64 \
		--cross-prefix=$TOOLCHAIN/bin/aarch64-linux-android- \
		--target-os=linux \
		--arch=aarch64 \
		--incdir=/home/eoollo/SVN/AppStreaming/ffmpeg/freetype-2.4.10/include/ \
		--sysroot=$SYSROOT \
		--extra-cflags=" -Os -fpic" \
		--extra-ldflags="$ADDI_LDFLAGS" \
		$ADDITIONAL_CONFIGURE_FLAG \

	make -j8 -B
	make install
}

#--extra-cflags=" -O3 -DANDROID -Dipv6mr_interface=ipv6mr_ifindex -fasm -Wno-psabi -fno-short-enums -fno-strict-aliasing" \
#--extra-cflags=" -Os -fpic -marm" \
#--nm=$PREBUILT/bin/aarch64-linux-android-nm \
#--extra-ldflags="-L/home/eoollo/SVN/AppStreaming/ffmpeg/freetype-2.4.10/freetype/arm64/lib/ -lfreetype" \
#--arch=aarch64 \
build_arm64

cd ../..