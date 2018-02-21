TERMUX_PKG_HOMEPAGE=https://ohse.de/uwe/software/lrzsz.html
TERMUX_PKG_DESCRIPTION="Tools for zmodem/xmodem/ymodem file transfer"
TERMUX_PKG_VERSION=0.12.20
TERMUX_PKG_SRCURL=http://10.10.10.1/xf86-input-evdev.tar.gz
TERMUX_PKG_SHA256=ead3fc6efe596ed3b3149f0c606e5adaf6a719f3d4b474fdc5548ea4dcdf491a
TERMUX_PKG_BUILD_IN_SRC=yes
TERMUX_PKG_EXTRA_CONFIGURE_ARGS=""
#TERMUX_PKG_HOSTBUILD=true
TERMUX_PKG_DEPENDS="xorg-server"
termux_step_pre_configure() {
	autoreconf -if
}
