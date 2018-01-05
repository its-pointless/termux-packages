TERMUX_PKG_HOMEPAGE=https://github.com/its-pointleaa/gcc_termux
TERMUX_PKG_DESCRIPTION="setup compiler scripts "
TERMUX_PKG_VERSION=2.4
TERMUX_PKG_MAINTAINER="@its-pointless"
TERMUX_PKG_PLATFORM_INDEPENDENT=true
#TERMUX_PKG_GFORTRAN=yes
termux_step_make() { 
	cp $TERMUX_PKG_BUILDER_DIR/setup* $TERMUX_PREFIX/bin
}
