TERMUX_SUBPKG_INCLUDE="lib/gcc/$TERMUX_HOST_PLATFORM/${TERMUX_PKG_VERSION}/adainclude  lib/gcc/$TERMUX_HOST_PLATFORM/${TERMUX_PKG_VERSION}/adalib  lib/gcc/$TERMUX_HOST_PLATFORM/${TERMUX_PKG_VERSION}/gnat.spec \
	libexec/gcc/arm-linux-androideabi/7.2.1/gnat1 bin/gnat bin/gnatbind bin/gnatchop bin/gnatclean bin/gnatfind bin/gnatkr bin/gnatlink bin/gnatls bin/gnatmake bin/gnatname bin/gnatprep bin/gnatxref lib/libgnat.so lib/libgnat-7.so lib/libgnarl.so lib/libgnarl-7.so"
TERMUX_SUBPKG_DESCRIPTION="the ada compiler"
TERMUX_SUBPKG_DEPENDS="gcc-7"
