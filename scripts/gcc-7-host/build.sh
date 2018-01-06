TERMUX_PKG_HOMEPAGE=http://gcc.gnu.org/
TERMUX_PKG_DESCRIPTION="GNU C compiler"
TERMUX_PKG_MAINTAINER="its-pointless @github"
TERMUX_PKG_DEPENDS="binutils, libgmp, libmpfr, libmpc, ndk-sysroot, libgcc, libisl, setup-scripts"
TERMUX_PKG_VERSION=7.2.1
TERMUX_PKG_MAINTAINER="@its-pointless github"
TERMUX_PKG_KEEP_STATIC_LIBRARIES=true
TERMUX_PKG_SRCURL=https://releases.linaro.org/components/toolchain/gcc-linaro/7.2-2017.11/gcc-linaro-7.2-2017.11.tar.xz
TERMUX_PKG_EXTRA_CONFIGURE_ARGS=" \
	--enable-languages=c++,c,fortran --with-system-zlib --disable-multilib \
	--target=${TERMUX_HOST_PLATFORM} --with-libgfortran \
	--disable-isl-version-check --disable-libstdcxx \
	--disable-tls --enable-lto --enable-gold=yes \
	--enable-host-libquadmath --enable-biomic-libs \
	--enable-default-pie --host=x86_64-linux-gnu \
	--disable-libssp --enable-libatomic-ifuncs=no \
	--enable-plugins host_alias=x86_64-linux-gnu --enable-threads \
	--enable-gold=default --enable-eh-frame-hdr-for-static \
	ac_cv_c_bigendian=no --disable-shared --enable-static"

TERMUX_PKG_SHA256=7b07095df50a10789f446cec421468f10c57fe8bb6a789a73dc758acf8475cb0

TERMUX_PKG_RM_AFTER_INSTALL="bin/gcc-ar bin/gcc-ranlib bin/*c++ bin/gcc-nm lib/gcc/*-linux-*/${TERMUX_PKG_VERSION}/plugin \
lib/gcc/*-linux-*/${TERMUX_PKG_VERSION}/include-fixed \
lib/gcc/*-linux-*/$TERMUX_PKG_VERSION/install-tools libexec/gcc/*-linux-*/${TERMUX_PKG_VERSION}/plugin \
libexec/gcc/*-linux-*/${TERMUX_PKG_VERSION}/install-tools share/man/man7 lib/gcc/$TERMUX_HOST_PLATFORM/$TERMUX_PKG_VERSION/libquadmath.a \
lib/gcc/$TERMUX_HOST_PLATFORM/$TERMUX_PKG_VERSION/libgfortran.a lib/gcc/$TERMUX_HOST_PLATFORM/$TERMUX_PKG_VERSION/libcaf_single.a
lib/libgfortran.a"
termux_step_pre_configure () {
	if [ "$TERMUX_ARCH" = "arm" ]; then
        	TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --with-arch=armv7-a --with-fpu=neon --with-float=softfp --enable-languages=c++,c,fortran,ada"
	elif [ "$TERMUX_ARCH" = "aarch64" ]; then
	        TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --with-arch=armv8-a --enable-languages=c++,c,fortran,ada"
	elif [ "$TERMUX_ARCH" = "i686" ]; then
		        # -mstackrealign -msse3 -m32
		TERMUX_PKG_EXTRA_CONFIGURE_ARGS+="  --with-arch=i686 --with-tune=atom --with-fpmath=sse"
	fi
mkdir -p $TERMUX_PKG_TMPDIR/lib
local BKA=""
if [ $TERMUX_ARCH = "x86_64" ]; then
	BKA="64"
fi
ln -s $TERMUX_STANDALONE_TOOLCHAIN/sysroot/usr/lib$BKA/libc.so $TERMUX_PKG_TMPDIR/lib/libpthread.so
	#source ~/termux-packages/termuxbuildenv.sh
export AR_FOR_TARGET="${TERMUX_HOST_PLATFORM}-ar"
export AS_FOR_TARGET="${TERMUX_HOST_PLATFORM}-as"
export _CC="${TERMUX_HOST_PLATFORM}-gcc"
export CFLAGS_FOR_TARGET=" -specs=${TERMUX_SCRIPTDIR}/termux.spec -fpic  -Os -I/data/data/com.termux/files/usr/include -I$TERMUX_STANDALONE_TOOLCHAIN/sysroot/usr/include -L$TERMUX_STANDALONE_TOOLCHAIN/sysroot/usr/lib -L${TERMUX_PREFIX}/lib -L$TERMUX_PKG_TMPDIR/lib"
#export CPP_FOR_TARGET="${TERMUX_HOST_PLATFORM}-cpp"
export CPPFLAGS_FOR_TARGET="-I/data/data/com.termux/files/usr/include -I$TERMUX_STANDALONE_TOOLCHAIN/sysroot/usr/include"
export CXXFLAGS_FOR_TARGET="-specs=${TERMUX_SCRIPTDIR}/termux.spec -I/data/data/com.termux/files/usr/include  -Os -I$TERMUX_STANDALONE_TOOLCHAIN/include/c++/4.9.x -I$TERMUX_STANDALONE_TOOLCHAIN/usr/include"
#export CXX_FOR_TARGET="${TERMUX_HOST_PLATFORM}-g++"
export LDFLAGS_FOR_TARGET=" -specs=${TERMUX_SCRIPTDIR}/termux.spec -L${TERMUX_PREFIX}/lib -L$TERMUX_STANDALONE_TOOLCHAIN/sysroot/usr/lib -L$TERMUX_PKG_TMPDIR/lib"
export LD_FOR_TARGET="${TERMUX_HOST_PLATFORM}-ld"
export PKG_CONFIG_FOR_TARGET="${TERMUX_HOST_PLATFORM}-pkg-config"
export RANLIB_FOR_TARGET="${TERMUX_HOST_PLATFORM}-ranlib"
#export FC_FOR_TARGET="${TERMUX_HOST_PLATFORM}-gfortran"
export LD_FOR_BUILD="ld"
export LDFLAGS_FOR_HOST="-L/usr/lib/x86_64-linux-gnu"
unset LD
unset CFLAGS
unset CC
unset AR
unset CPP
unset CXXFLAGS
unset CPPFLAGS
unset RANLIB
unset FC
unset AS
unset CXX
unset LDFLAGS
unset LIBEXEC_FLAG
export READELF=x86_64-linux-gnu-readelf
export OBJDUMP=x86_64-linux-gnu-objdump
export STRIP=x86_64-linux-gnu-strip
export LD_FOR_BUILD=x86_64-linux-gnu-ld
export LD_FOR_HOST=x86_64-linux-gnu-ld
export LD=x86_64-linux-gnu-ld
unset PREFIX
#TOOLCHAINVERSION=$( basename $TERMUX_STANDALONE_TOOLCHAIN)
TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --libexecdir=$GCC7_HOST_PREFIX/libexec  --prefix=$GCC7_HOST_PREFIX   --with-as=$TERMUX_STANDALONE_TOOLCHAIN/bin/$TERMUX_HOST_PLATFORM-as \
	--with-sysroot=$TERMUX_STANDALONE_TOOLCHAIN/sysroot \
	 --with-gnu-as --enable-graphite --prefix=$GCC7_HOST_PREFIX  --with-gxx-include-dir=$TERMUX_STANDALONE_TOOLCHAIN/include/c++/4.9.x "
#TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --host=x86_64-linux-gnu --target=arm-linux-androideabi --with-sysroot=/home/builder/.termux-build/_lib/16-arm-21-v3/sysroot --disable-rpath-hack --disable-multilib --enable-gold=yes --enable-tls --enable-libgomp --enable-languages=c,c++,fortran,ada --disable-dependency-tracking --prefix=/home/builder/gcc-7 --disable-rpath --disable-rpath-hack --host=x86_64-linux-gnu --with-system-zlib --disable-multilib --target=arm-linux-androideabi --with-libgfortran --disable-isl-version-check --enable-lto --enable-gold=yes --enable-default-pie --disable-nls --enable-shared --enable-static host_alias=x86_64-linux-gnu target_alias=arm-linux-androideabi --enable-libgomp --without-libatomic --disable-libatomic --with-gnu-as --disable-libstdcxx --program-transform-name=s&^&arm-linux-androideabi-& --with-gnu-as --enable-graphite --with-as=/home/builder/.termux-build/_lib/16-arm-21-v3/bin/arm-linux-androideabi-as --disable-libssp --with-gxx-include-dir=/home/builder/.termux-build/_lib/16-arm-21-v3/include/c++/4.9.x "

}

termux_step_make () {
	make -j $TERMUX_MAKE_PROCESSES 
	make install
	if [ $TERMUX_ARCH = "arm" ]; then
		$_CC -Wl,--whole-archive gcc/ada/rts/libgnat.a -Wl,--no-whole-archive -shared -lm -o $TERMUX_PREFIX/lib/libgnat-7.so
		ln -s $TERMUX_PREFIX/lib/libgnat-7.so $TERMUX_PREFIX/lib/libgnat.so
		$_CC -Wl,--whole-archive gcc/ada/rts/libgnarl.a -Wl,--no-whole-archive -lm -shared -o $TERMUX_PREFIX/lib/libgnarl-7.so
		ln -s $TERMUX_PREFIX/lib/libgnarl-7.so $TERMUX_PREFIX/lib/libgnarl.so
	fi
	exit
	
}

