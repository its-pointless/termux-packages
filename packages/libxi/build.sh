TERMUX_PKG_HOMEPAGE=https://www.x.org
TERMUX_PKG_VERSION=1.7.9
TERMUX_PKG_SRCURL=https://www.x.org/archive//individual/lib/libXi-$TERMUX_PKG_VERSION.tar.bz2
TERMUX_PKG_SHA256=c2e6b8ff84f9448386c1b5510a5cf5a16d788f76db018194dacdc200180faf45
TERMUX_PKG_DEPENDS="libxext, x11-proto, libxfixes"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--enable-malloc0returnsnull"
