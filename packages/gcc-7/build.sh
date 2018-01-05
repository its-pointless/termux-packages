TERMUX_PKG_HOMEPAGE=http://gcc.gnu.org/
TERMUX_PKG_DESCRIPTION="GNU C compiler"
TERMUX_PKG_MAINTAINER="its-pointless @github"
TERMUX_PKG_DEPENDS="binutils, libgmp, libmpfr, libmpc, ndk-sysroot, libgcc, libisl, setup-scripts, libandroid-support"
TERMUX_PKG_VERSION=7.2.1
#TERMUX_PKG_GFORTRAN=yes
TERMUX_PKG_LIBGFORTRAN=yes
TERMUX_PKG_MAINTAINER="@its-pointless github"
#TERMUX_PKG_REVISION=3
TERMUX_PKG_GCC7BUILD=yes
TERMUX_PKG_KEEP_STATIC_LIBRARIES="true"
# http://ftp.gnu.org/gnu/gcc/gcc-6.4.0/gcc-6.4.0.tar.xz
#TERMUX_PKG_SRCURL=http://ftp.gnu.org/gnu/gcc/gcc-${TERMUX_PKG_VERSION}/gcc-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SRCURL=https://releases.linaro.org/components/toolchain/gcc-linaro/7.2-2017.11/gcc-linaro-7.2-2017.11.tar.xz
TERMUX_PKG_EXTRA_CONFIGURE_ARGS=" \
	--enable-languages=c,c++,fortran --with-system-zlib --disable-multilib \
	--target=${TERMUX_HOST_PLATFORM} --with-libgfortran --enable-static \
	--with-gmp=$TERMUX_PREFIX --with-mpfr=$TERMUX_PREFIX --with-mpc=$TERMUX_PREFIX \
	--with-stage1-ldflags=\"-specs=$TERMUX_SCRIPTDIR/termux.spec\" \
	--with-isl-include=$TERMUX_PREFIX/include --with-isl-lib=$TERMUX_PREFIX/lib \
	--disable-isl-version-check --disable-libssp \
	--disable-tls --enable-lto --enable-gold=yes --enable-libatomic \
	--enable-host-shared --enable-host-libquadmath --enable-libatomic-ifuncs=no \
	--enable-default-pie ac_cv_c_bigendian=no --with-libatomic --disable-libstdcxx \
	--enable-version-specific-runtime-libs --enable-eh-frame-hdr-for-static \
	--disable-mpx --without-mpx"

#TERMUX_PKG_SHA256=1cf7adf8ff4b5aa49041c8734bbcf1ad18cc4c94d0029aae0f4e48841088479a
TERMUX_PKG_SHA256=7b07095df50a10789f446cec421468f10c57fe8bb6a789a73dc758acf8475cb0
if [ "$TERMUX_ARCH" = "arm" ]; then
	TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --with-arch=armv7-a --with-fpu=neon --with-float=softfp \
	       	--enable-languages=c,c++,fortran,ada,go  --with-libada --with-libatomic --enable-libatomic \
	       	--with-stage1-ldflags=-specs=$TERMUX_SCRIPTDIR/termux-gnat.spec"
	CFLAGS+=" -static-libgcc"
	CXXFLAGS+=" -static-libgcc"
	LDFLAGS+=" -static-libgcc"
elif [ "$TERMUX_ARCH" = "aarch64" ]; then
	TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --with-arch=armv8-a"
elif [ "$TERMUX_ARCH" = "i686" ]; then
        # -mstackrealign -msse3 -m32
        TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --with-arch=i686 --with-tune=atom --with-fpmath=sse"
fi
TERMUX_PKG_RM_AFTER_INSTALL="bin/gcc-ar bin/gcc-ranlib bin/*c++ bin/gcc-nm lib/gcc/*-linux-*/${TERMUX_PKG_VERSION}/plugin \
lib/gcc/*-linux-*/${TERMUX_PKG_VERSION}/include-fixed \
lib/gcc/*-linux-*/$TERMUX_PKG_VERSION/install-tools libexec/gcc/*-linux-*/${TERMUX_PKG_VERSION}/plugin \
libexec/gcc/*-linux-*/${TERMUX_PKG_VERSION}/install-tools share/man/man7 lib/gcc/$TERMUX_HOST_PLATFORM/$TERMUX_PKG_VERSION/libquadmath.a \
lib/gcc/$TERMUX_HOST_PLATFORM/$TERMUX_PKG_VERSION/libgfortran.a lib/gcc/$TERMUX_HOST_PLATFORM/$TERMUX_PKG_VERSION/libcaf_single.a lib/libgfortran.a"

#source ~/termux-packages/termuxbuildenv.sh
termux_step_pre_configure () {
if [ "$TERMUX_ARCH" = "arm" ]; then
       TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --with-arch=armv7-a --with-fpu=neon --with-float=softfp --enable-languages=c,c++,fortran,ada  --with-libada"
	#cp $GCC7_HOST_PREFIX/lib/gcc/$TERMUX_HOST_PLATFORM/$TERMUX_PKG_VERSION/adalib/*.so $TERMUX_PREFIX/lib
elif [ "$TERMUX_ARCH" = "aarch64" ]; then
	        TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --with-arch=armv8-a --enable-fix-cortex-a53-835769 --enable-languages=c,c++,fortran" #,ada"
	elif [ "$TERMUX_ARCH" = "i686" ]; then
        # -mstackrealign -msse3 -m32
       TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --with-arch=i686 --with-tune=atom --with-fpmath=sse"
fi

	
	
	
export AR_FOR_TARGET="${TERMUX_HOST_PLATFORM}-ar"
export AS_FOR_TARGET="${TERMUX_HOST_PLATFORM}-as"
export CC_FOR_TARGET="${TERMUX_HOST_PLATFORM}-gcc"
export CFLAGS_FOR_TARGET=" -specs=${TERMUX_SCRIPTDIR}/termux.spec -Os"
export CPP_FOR_TARGET="${TERMUX_HOST_PLATFORM}-cpp"
export CPPFLAGS_FOR_TARGET="-I/data/data/com.termux/files/usr/include"
export CXXFLAGS_FOR_TARGET="-specs=${TERMUX_SCRIPTDIR}/termux.spec -I/data/data/com.termux/files/usr/include -I$TERMUX_STANDALONE_TOOLCHAIN/sysroot/usr/include  -Os"
export export CXXFLAGS_FOR_HOST=$CXXFLAGS_FOR_TARGET
export CXX_FOR_TARGET="${TERMUX_HOST_PLATFORM}-g++ $CPPFLAGS_FOR_TARGET"
export LDFLAGS_FOR_TARGET=" -specs=${TERMUX_SCRIPTDIR}/termux.spec -L${TERMUX_PREFIX}/lib "
export LD_FOR_TARGET="${TERMUX_HOST_PLATFORM}-ld"
export PKG_CONFIG_FOR_TARGET="${TERMUX_HOST_PLATFORM}-pkg-config"
export RANLIB_FOR_TARGET="${TERMUX_HOST_PLATFORM}-ranlib"
export FC_FOR_TARGET="${TERMUX_HOST_PLATFORM}-gfortran"
export LD_FOR_BUILD="ld"
if [ $TERMUX_ARCH = "arm" ]; then
	export CFLAGS_FOR_TARGET=" -specs=${TERMUX_SCRIPTDIR}/termux-gnat.spec -Os"
	export LDFLAGS_FOR_TARGET=" -specs=${TERMUX_SCRIPTDIR}/termux-gnat.spec -L${TERMUX_PREFIX}/lib"
	export CXXFLAGS_FOR_TARGET="-specs=${TERMUX_SCRIPTDIR}/termux-gnat.spec -I$TERMUX_STANDALONE_TOOLCHAIN/sysroot/usr/include  -Os"
fi
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
#PATH=/home/builder/.termux-build/_lib/gcc-7-host/bin:$PATH
}

termux_step_make () {
export 	ac_cv_c_bigendian=no
make -j $TERMUX_MAKE_PROCESSES all
	
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
}


#termux_step_make_install () {
#	make install
#fi
#}

termux_step_post_make_install () {
	# Android 5.0 only supports PIE binaries, so build that by default with a specs file:
	local GCC_SPECS=$TERMUX_PREFIX/lib/gcc/$TERMUX_HOST_PLATFORM/$TERMUX_PKG_VERSION/specs
	sed 's/--as-needed -lgnat --no-as-needed//g' $TERMUX_SCRIPTDIR/termux.spec >  $GCC_SPECS
	if [ $TERMUX_ARCH = "arm" ]; then
		cp $TERMUX_PKG_BUILDER_DIR/gnat.spec $TERMUX_PREFIX/lib/gcc/$TERMUX_HOST_PLATFORM/$TERMUX_PKG_VERSION/
	fi
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
	mv gcov gcov-7
	mv gcov-tool gcov-tool-7
	mv gcov-dump gcov-dump-7
	mv gcc gcc-7
	mv gfortran gfortran-7
	mv g++ g++-7
	mv cpp cpp-7
	rm ${TERMUX_HOST_PLATFORM}-g++; ln -fs g++-7 ${TERMUX_HOST_PLATFORM}-g++-7
	rm ${TERMUX_HOST_PLATFORM}-gcc; ln -fs gcc-7 ${TERMUX_HOST_PLATFORM}-gcc-7
	rm ${TERMUX_HOST_PLATFORM}-gcc-${TERMUX_PKG_VERSION}; ln -s gcc-7 ${TERMUX_HOST_PLATFORM}-gcc-${TERMUX_PKG_VERSION}
        rm ${TERMUX_HOST_PLATFORM}-gfortran;  ln -fs gfortran-7 ${TERMUX_HOST_PLATFORM}-gfortran-7
	ln -fs cpp-7 ${TERMUX_HOST_PLATFORM}-cpp-7
	# Add symbolic links for libgfortran build specific links library to LD_LIBRARY_PATH
	if [ $TERMUX_ARCH = "x86_64" ] || [ $TERMUX_ARCH = "i686" ]; then
	     ln -fs ${TERMUX_PREFIX}/lib/gcc/${TERMUX_HOST_PLATFORM}/${TERMUX_PKG_VERSION}/libquadmath*.so* $TERMUX_PREFIX/lib
	fi
	rm ${TERMUX_PREFIX}/lib/gcc/${TERMUX_HOST_PLATFORM}/${TERMUX_PKG_VERSION}/libgomp*.so*
	mv ${TERMUX_PREFIX}/lib/gcc/${TERMUX_HOST_PLATFORM}/${TERMUX_PKG_VERSION}/libgomp.a ${TERMUX_PREFIX}/lib/libgomp.a.7.2
	ln -sf ${TERMUX_PREFIX}/lib/gcc/${TERMUX_HOST_PLATFORM}/${TERMUX_PKG_VERSION}/libgfortran* $TERMUX_PREFIX/lib
	ln -sf ${TERMUX_PREFIX}/lib/gcc/${TERMUX_HOST_PLATFORM}/${TERMUX_PKG_VERSION}/libatomic* $TERMUX_PREFIX/lib
	mv /data/data/com.termux/files/usr/lib/gcc/$TERMUX_HOST_PLATFORM/${TERMUX_PKG_VERSION}/include/omp.h /data/data/com.termux/files/usr/lib/gcc/$TERMUX_HOST_PLATFORM/${TERMUX_PKG_VERSION}/include/omp.h.7.2
	if [ $TERMUX_ARCH = "arm" ]; then
	mv ${TERMUX_PREFIX}/lib/gcc/${TERMUX_HOST_PLATFORM}/${TERMUX_PKG_VERSION}/adalib/*.so $TERMUX_PREFIX/lib
	fi
	
	rm '/data/data/com.termux/files/usr/lib/libatomic.a'
}

termux_step_post_massage() {
	rm -f $TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/bin/*-6
#sed -i 's/\-landroid-support//g' $TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/lib/gcc/${TERMUX_HOST_PLATFORM}/${TERMUX_PKG_VERSION}/specs
	#	if [ $TERMUX_ARCH_BITS = "64" ]; then
#		mv $TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/lib64/* $TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/lib
#	fi
	cd $TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/share/man/man1/
	
	for M in *.1
	do
	N=${M/.1/-7.1}
	echo " mv $M to $N"
	mv $M $N
			        done
echo "#!$TERMUX_PREFIX/bin/sh" > $TERMUX_PKG_MASSAGEDIR/../subpackages/libgomp-7/massage/DEBIAN/postinst
echo "setuplibgomp-7" >> $TERMUX_PKG_MASSAGEDIR/../subpackages/libgomp-7/massage/DEBIAN/postinst

}

