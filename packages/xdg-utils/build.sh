TERMUX_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/xdg-utils
TERMUX_PKG_VERSION=1.1.2
TERMUX_PKG_SRCURL=https://portland.freedesktop.org/download/xdg-utils-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=951952e2c6bb21214e0bb54e0dffa057d30f5563300225c24c16fba846258bcc
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_PLATFORM_INDEPENDENT=true

termux_step_post_make_install () {
	mv $TERMUX_PREFIX/bin/xdg-open $TERMUX_PREFIX/bin/x11-open
}
