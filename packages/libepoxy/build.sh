TERMUX_PKG_HOMEPAGE=https://github.com/anholt/libepoxy
TERMUX_PKG_VERSION=1.4.0
TERMUX_PKG_SRCURL=https://github.com/anholt/libepoxy/releases/download/v${TERMUX_PKG_VERSION%.0}/libepoxy-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=25a906b14a921bc2b488cfeaa21a00486fe92630e4a9dd346e4ecabeae52ab41
TERMUX_PKG_DESCRIPTION="Library handling OpenGL function pointer management"
TERMUX_PKG_DEPENDS="libx11, libmesa"
#TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--disable-glx"

termux_step_pre_configure () {
	export EGL_CFLAGS=$CFLAGS
	export EGL_LIBS="-L$TERMUX_STANDALONE_TOOLCHAIN/sysroot/lib -lEGL"
}
