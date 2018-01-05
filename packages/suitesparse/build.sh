TERMUX_PKG_HOMEPAGE=http://faculty.cse.tamu.edu/davis/suitesparse.html
TERMUX_PKG_DESCRIPTION="a suite of sparse matrix software"
TERMUX_PKG_VERSION=4.5.6
TERMUX_PKG_SRCURL=http://faculty.cse.tamu.edu/davis/SuiteSparse/SuiteSparse-4.5.6.tar.gz
TERMUX_PKG_SHA256=de5fb496bdc029e55955e05d918a1862a177805fbbd5b957e8b5ce6632f6c77e
TERMUX_PKG_MAINTAINER=" @its-pointless github"
TERMUX_PKG_BUILD_IN_SRC=yes
TERMUX_PKG_CLANG=no
TERMUX_PKG_GCC7BUILD=yes
TERMUX_PKG_DEPENDS="libgfortran4"
termux_step_make(){
	rm $TERMUX_PREFIX/include/cs.h -f
	LDFLAGS+=" -lm -lgfortran"
	termux_setup_cmake
	make config shared=1 cc=$TERMUX_HOST_PLATFORM-clang prefix=$TERMUX_PREFIX FC=$TERMUX_HOST_PLATFORM-gfortran 
	make metis -j $TERMUX_MAKE_PROCESSES
	make library -j $TERMUX_MAKE_PROCESSES
}
termux_step_make_install () {
	make install INSTALL=$TERMUX_PREFIX
}
