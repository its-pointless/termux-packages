TERMUX_PKG_HOMEPAGE=https://www.x.org
TERMUX_PKG_VERSION=1.1.3
TERMUX_PKG_SRCURL=https://www.x.org/releases/X11R7.7/src/lib/libXt-$TERMUX_PKG_VERSION.tar.bz2
TERMUX_PKG_SHA256=8db593c3fc5ffc4e9cd854ba50af1eac9b90d66521ba17802b8f1e0d2d7f05bd
TERMUX_PKG_DEPENDS="libice, libsm, libx11"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--enable-malloc0returnsnull"

termux_step_pre_configure () {
	export CFLAGS_FOR_BUILD=" "
	export LDFLAGS_FOR_BUILD=" "
}
