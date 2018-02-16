TERMUX_PKG_HOMEPAGE=https://ohse.de/uwe/software/lrzsz.html
TERMUX_PKG_DESCRIPTION="Tools for zmodem/xmodem/ymodem file transfer"
TERMUX_PKG_VERSION=1.7.3
TERMUX_PKG_SRCURL=https://github.com/saitoha/libsixel/archive/v1.7.3.tar.gz
TERMUX_PKG_SHA256=5a6e369b839e406a85cb54f2700e48d211a78618d7d4b6e3cd81d97dfda9ade9
#TERMUX_PKG_BUILD_IN_SRC=yes
TERMUX_PKG_EXTRA_CONFIGURE_ARGS=""
#TERMUX_PKG_HOSTBUILD=true
termux_step_pre_configure() {
	CFLAGS+=" -D__USE_GNU"
	PYTHON=python3
}
