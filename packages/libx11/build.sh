TERMUX_PKG_VERSION=1.6.4
TERMUX_PKG_SRCURL=https://www.x.org/archive//individual/lib/libX11-$TERMUX_PKG_VERSION.tar.bz2
TERMUX_PKG_DEPENDS="x11-proto, xtrans, libxcb, libandroid-support"
TERMUX_PKG_SHA256=b7c748be3aa16ec2cbd81edc847e9b6ee03f88143ab270fb59f58a044d34e441
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-xthreads
--enable-malloc0returnsnull
"
