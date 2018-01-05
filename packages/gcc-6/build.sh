TERMUX_PKG_HOMEPAGE=http://gcc.gnu.org/
TERMUX_PKG_DESCRIPTION="GNU C compiler"
TERMUX_PKG_MAINTAINER="its-pointless @github"
TERMUX_PKG_DEPENDS="binutils, libgmp, libmpfr, libmpc, ndk-sysroot, libgcc, libisl, setup-scripts"
TERMUX_HOST_PLATFORM="${TERMUX_ARCH}-linux-android"
if [ $TERMUX_ARCH = "arm" ]; then TERMUX_HOST_PLATFORM="${TERMUX_HOST_PLATFORM}eabi"; fi
TERMUX_PKG_VERSION=6.4.0
TERMUX_PKG_GCC7BUILD=yes
TERMUX_PKG_MAINTAINER=" @its-pointless github"
TERMUX_PKG_SRCURL=http://ftp.gnu.org/gnu/gcc/gcc-${TERMUX_PKG_VERSION}/gcc-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_EXTRA_CONFIGURE_ARGS=" \
	--enable-languages=c,c++,fortran --with-system-zlib --disable-multilib \
	--target=${TERMUX_HOST_PLATFORM} --with-libgfortran \
	--with-gmp=$TERMUX_PREFIX --with-mpfr=$TERMUX_PREFIX --with-mpc=$TERMUX_PREFIX \
	--with-stage1-ldflags=\"-specs=$TERMUX_SCRIPTDIR/termux.spec\" \
	--with-isl-include=$TERMUX_PREFIX/include --with-isl-lib=$TERMUX_PREFIX/lib \
	--disable-isl-version-check \
	--disable-tls --enable-lto --enable-gold=yes \
	--enable-host-shared --enable-host-libquadmath \
	--enable-default-pie ac_cv_c_bigendian=no"

TERMUX_PKG_SHA256=850bf21eafdfe5cd5f6827148184c08c4a0852a37ccf36ce69855334d2c914d4
if [ "$TERMUX_ARCH" = "arm" ]; then
        TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --with-arch=armv7-a --with-fpu=neon --with-float=softfp"
elif [ "$TERMUX_ARCH" = "aarch64" ]; then
	TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --with-arch=armv8-a"
elif [ "$TERMUX_ARCH" = "i686" ]; then
        # -mstackrealign -msse3 -m32
        TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --with-arch=i686 --with-tune=atom --with-fpmath=sse"
fi
TERMUX_PKG_RM_AFTER_INSTALL="bin/gcc-ar bin/gcc-ranlib bin/*c++ bin/gcc-nm lib/gcc/*-linux-*/${TERMUX_PKG_VERSION}/plugin \
lib/gcc/*-linux-*/${TERMUX_PKG_VERSION}/include-fixed \
lib/gcc/*-linux-*/$TERMUX_PKG_VERSION/install-tools libexec/gcc/*-linux-*/${TERMUX_PKG_VERSION}/plugin \
libexec/gcc/*-linux-*/${TERMUX_PKG_VERSION}/install-tools share/man/man7"

#source ~/termux-packages/termuxbuildenv.sh
export AR_FOR_TARGET="${TERMUX_HOST_PLATFORM}-ar"
export AS_FOR_TARGET="${TERMUX_HOST_PLATFORM}-as"
export CC_FOR_TARGET="${TERMUX_HOST_PLATFORM}-gcc"
export CFLAGS_FOR_TARGET=" -specs=${TERMUX_SCRIPTDIR}/termux.spec -Os"
export CPP_FOR_TARGET="${TERMUX_HOST_PLATFORM}-cpp"
export CPPFLAGS_FOR_TARGET="-I/data/data/com.termux/files/usr/include"
export CXXFLAGS_FOR_TARGET="-specs=${TERMUX_SCRIPTDIR}/termux.spec -Os"
export CXX_FOR_TARGET="${TERMUX_HOST_PLATFORM}-g++"
export LDFLAGS_FOR_TARGET=" -specs=${TERMUX_SCRIPTDIR}/termux.spec -L${TERMUX_PREFIX}/lib"
export LD_FOR_TARGET="${TERMUX_HOST_PLATFORM}-ld"
export PKG_CONFIG_FOR_TARGET="${TERMUX_HOST_PLATFORM}-pkg-config"
export RANLIB_FOR_TARGET="${TERMUX_HOST_PLATFORM}-ranlib"
export FC_FOR_TARGET="${TERMUX_HOST_PLATFORM}-gfortran"
export LD_FOR_BUILD="ld"

termux_step_pre_configure () {
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
export ac_cv_c_bigendian=no
}

termux_step_make () {
	make -j $TERMUX_MAKE_PROCESSES all-gcc
	
LD=${LD_FOR_TARGET}
AR=${AR_FOR_TARGET}
RANLIB=${RANLIB_FOR_TARGET}
CC=${CC_FOR_TARGET}
AS=${AS_FOR_TARGET}
CXX=${CXX_FOR_TARGET}
CFLAGS=${CFLAGS_FOR_TARGET} 
DFLAGS=${LDFLAGS_FOR_TARGET}
CPPFLAGS=${CPPFLAGS_FOR_TARGET}
CPP=${CPP_FOR_TARGET} 
FC=${FC_FOR_TARGET} 

        if [ $TERMUX_ARCH = "x86_64" ] || [ $TERMUX_ARCH = "i686" ]; then
		mkdir libquadmath
		 cd libquadmath
		 ../../src/libquadmath/configure --disable-multilib --host=$TERMUX_HOST_PLATFORM --prefix=${TERMUX_PREFIX} --libdir=${TERMUX_PREFIX}/lib  \
			 --libexecdir=$TERMUX_PREFIX/libexec LD=${LD_FOR_TARGET} --target=$TERMUX_HOST_PLATFORM \
			toolexeclibdir=${TERMUX_PREFIX}/lib --enable-version-specific-runtime-libs --enable-fast-install=no
			./config.status
			make -j $TERMUX_MAKE_PROCESSES
			cd ../
	fi
	mkdir libgfortran
	cd libgfortran
	cp ../../src/libgcc/gthr-posix.h ./gthr-default.h
	../../src/libgfortran/configure --disable-multilib --host=$TERMUX_HOST_PLATFORM --prefix=${TERMUX_PREFIX} --libdir=${TERMUX_PREFIX}/lib \
	--libexecdir=$TERMUX_PREFIX/libexec LD=${LD_FOR_TARGET} --target=$TERMUX_HOST_PLATFORM  toolexeclibdir=${TERMUX_PREFIX}/lib \
	--enable-version-specific-runtime-libs --enable-fast-install=no
	./config.status
	make -j $TERMUX_MAKE_PROCESSES
}


termux_step_make_install () {
	make install-gcc
	if [ $TERMUX_ARCH = "x86_64" ] || [ $TERMUX_ARCH = "i686" ]; then
		cd libquadmath
		make install
		cd ../
	fi
	cd libgfortran
	make install
	
}

termux_step_post_make_install () {
	# Android 5.0 only supports PIE binaries, so build that by default with a specs file:
	local GCC_SPECS=$TERMUX_PREFIX/lib/gcc/$TERMUX_HOST_PLATFORM/$TERMUX_PKG_VERSION/specs
	cp $TERMUX_SCRIPTDIR/termux.spec $GCC_SPECS

	if [ $TERMUX_ARCH = "i686" ]; then
		# See https://github.com/termux/termux-packages/issues/3
		# and https://github.com/termux/termux-packages/issues/14
		cat >> $GCC_SPECS <<HERE

*link_emulation:
elf_i386

*dynamic_linker:
/system/bin/linker
HERE
	fi

	# Replace hardlinks with symlinks and fix it so it coexists with clang.
	cd $TERMUX_PREFIX/bin
	rm $TERMUX_HOST_PLATFORM-gcc-nm
	rm $TERMUX_HOST_PLATFORM-gcc-ar
	rm $TERMUX_HOST_PLATFORM-gcc-ranlib
	mv gcov gcov-6
	mv gcov-tool gcov-tool-6
	mv gcov-dump gcov-dump-6
	mv gcc gcc-6
	mv gfortran gfortran-6
	mv g++ g++-6
	mv cpp cpp-6
	rm ${TERMUX_HOST_PLATFORM}-g++; ln -fs g++-6 ${TERMUX_HOST_PLATFORM}-g++-6
	rm ${TERMUX_HOST_PLATFORM}-gcc; ln -fs gcc-6 ${TERMUX_HOST_PLATFORM}-gcc-6
	rm ${TERMUX_HOST_PLATFORM}-gcc-${TERMUX_PKG_VERSION}; ln -s gcc-6 ${TERMUX_HOST_PLATFORM}-gcc-${TERMUX_PKG_VERSION}
        rm ${TERMUX_HOST_PLATFORM}-gfortran; ln -fs gfortran-6 ${TERMUX_HOST_PLATFORM}-gfortran; ln -fs gfortran-6 ${TERMUX_HOST_PLATFORM}-gfortran-6
	ln -fs cpp-6 ${TERMUX_HOST_PLATFORM}-cpp-6
	# Add symbolic links for libgfortran build specific links library to LD_LIBRARY_PATH
	if [ $TERMUX_ARCH = "x86_64" ] || [ $TERMUX_ARCH = "i686" ]; then
		ln -fs ${TERMUX_PREFIX}/lib/gcc/${TERMUX_HOST_PLATFORM}/${TERMUX_PKG_VERSION}/libquadmath*.so* $TERMUX_PREFIX/lib
	fi
	ln -fs ${TERMUX_PREFIX}/lib/gcc/${TERMUX_HOST_PLATFORM}/${TERMUX_PKG_VERSION}/libgfortran* $TERMUX_PREFIX/lib
	rm $TERMUX_PREFIX/lib/libgfortran.spec
}
termux_step_post_massage() {
	rm -f $TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/bin/*-7
	cd $TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/lib
        rm -f $TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/lib/libgfortran.so
	rm $TERMUX_PKG_MASSAGEDIR/data/data/com.termux/files/usr/share/man/ -r
}
