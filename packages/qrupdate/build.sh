TERMUX_PKG_HOMEPAGE=https://sourceforge.net/projects/qrupdate/
TERMUX_PKG_DESCRIPTION="a Fortran library for fast updates of QR and Cholesky decompositions"
TERMUX_PKG_VERSION=1.1.2
TERMUX_PKG_SHA256=e2a1c711dc8ebc418e21195833814cb2f84b878b90a2774365f0166402308e08
TERMUX_PKG_SRCURL=https://sourceforge.net/projects/qrupdate/files/qrupdate/1.2/qrupdate-1.1.2.tar.gz
TERMUX_PKG_DEPENDS="openblas"
TERMUX_PKG_GCC7BUILD=yes
TERMUX_PKG_BUILD_IN_SRC=yes
termux_step_make() {
	echo $FC
	F77=$FC
	rm -f $TERMUX_PREFIX/lib/libqrupdate* 
	FFLAGS+=" -L$TERMUX_PREFIX/lib"
	make solib -j $TERMUX_MAKE_PROCESSES
	
}
