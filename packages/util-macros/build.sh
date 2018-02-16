TERMUX_PKG_HOMEPAGE=https://ohse.de/uwe/software/lrzsz.html
TERMUX_PKG_DESCRIPTION="Tools for zmodem/xmodem/ymodem file transfer"
TERMUX_PKG_VERSION=1.19.1
TERMUX_PKG_SRCURL=https://www.x.org/pub/individual/util/util-macros-1.19.1.tar.bz2
TERMUX_PKG_SHA256=18d459400558f4ea99527bc9786c033965a3db45bf4c6a32eefdc07aa9e306a6
#TERMUX_PKG_BUILD_IN_SRC=yes
TERMUX_PKG_EXTRA_CONFIGURE_ARGS=""
#TERMUX_PKG_HOSTBUILD=true
termux_step_post_make_install() {
    mv $TERMUX_PREFIX/share/pkgconfig/* $TERMUX_PREFIX/lib/pkgconfig
}
