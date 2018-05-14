TERMUX_PKG_HOMEPAGE=https://github.com/diocles/apt-transport-tor
TERMUX_PKG_DESCRIPTION="Easily install packages via Tor"
TERMUX_PKG_VERSION=0.2.1
TERMUX_PKG_SRCURL=https://github.com/diocles/apt-transport-tor/archive/v0.2.1.tar.gz
TERMUX_PKG_SHA256=3864d2f7fc8c14c0fa4b404848478a556d5a245e36f2ac88ee49c3ff31f29755
TERMUX_PKG_BUILD_IN_SRC=yes
TERMUX_PKG_DEPENDS="tor"
termux_step_pre_configure() {
	rm /data/data/com.termux/files/usr/lib/apt/methods/tor* -rf
	autoreconf -i
}
