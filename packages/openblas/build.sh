TERMUX_PKG_HOMEPAGE=http://github.com/xianyi/OpenBLAS/archive/v0.2.20.tar.gz
TERMUX_PKG_DESCRIPTION="blas"
TERMUX_PKG_VERSION=0.2.20
TERMUX_PKG_SHA256=5ef38b15d9c652985774869efd548b8e3e972e1e99475c673b25537ed7bcf394
# Use a mirror as upstream has issues:
# TERMUX_PKG_SRCURL=http://gondor.apana.org.au/~herbert/dash/files/dash-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SRCURL=http://github.com/xianyi/OpenBLAS/archive/v0.2.20.tar.gz
#TERMUX_PKG_GFORTRAN=yes
TERMUX_PKG_CLANG=no
TERMUX_PKG_GCC7BUILD=yes
TERMUX_PKG_REVISION=2
TERMUX_PKG_NO_DEVELSPLIT="yes"
TERMUX_PKG_BUILD_IN_SRC=yes
TERMUX_PKG_DEPENDS="libgfortran4"

termux_step_configure() {
#	export PATH=/home/builder/.termux-build/_lib/gcc-7-host/bin:$PATH
	return 0;
}
termux_step_make() {
	if [ $TERMUX_ARCH = "aarch64" ] ; then
		make TARGET=ARMV8 BINARY=64 HOSTCC=gcc CC=aarch64-linux-android-gcc FC=aarch64-linux-android-gfortran F_COMPILER=GFORTRAN NUM_THREADS=32  -j $TERMUX_MAKE_PROCESSES
	elif [ $TERMUX_ARCH = "arm" ]; then 
		make TARGET=ARMV7 HOSTCC=gcc ARM_SOFTFP_ABI=1  CC=arm-linux-androideabi-gcc FC=arm-linux-androideabi-gfortran F_COMPILER=GFORTRAN NUM_THREADS=32 -j $TERMUX_MAKE_PROCESSES
	elif [ $TERMUX_ARCH = "x86_64" ]; then
		make TARGET=SANDYBRIDGE HOSTCC=gcc  CC=x86_64-linux-android-gcc FC=x86_64-linux-android-gfortran F_COMPILER=GFORTRAN NUM_THREADS=32 -j $TERMUX_MAKE_PROCESSES
	else make TARGET=ATOM  HOSTCC=gcc LD=i686-linux-android-ld  CC=i686-linux-android-gcc  F_COMPILER=GFORTRAN FC=i686-linux-android-gfortran  BINARY=32 NUM_THREADS=32 -j $TERMUX_MAKE_PROCESSES
	make shared TARGET=ATOM  HOSTCC=gcc LD=i686-linux-android-ld  F_COMPILER=GFORTRAN CC=i686-linux-android-gcc FC=i686-linux-android-gfortran  BINARY=32 NUM_THREADS=32 -j $TERMUX_MAKE_PROCESSES
	fi
}
termux_step_post_make_install() {
	ln -sf $TERMUX_PREFIX/lib/libopenblas.so $TERMUX_PREFIX/lib/liblapack.so 
	ln -sf $TERMUX_PREFIX/lib/libopenblas.so $TERMUX_PREFIX/lib/libblas.so
}
