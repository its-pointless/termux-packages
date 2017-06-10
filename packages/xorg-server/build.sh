TERMUX_PKG_VERSION=1.19.1
TERMUX_PKG_SRCURL=https://www.x.org/archive//individual/xserver/xorg-server-$TERMUX_PKG_VERSION.tar.bz2
TERMUX_PKG_SHA256=79ae2cf39d3f6c4a91201d8dad549d1d774b3420073c5a70d390040aa965a7fb
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-libdrm
--enable-glx
--disable-mitshm
--enable-composite
--enable-xres
--enable-record
--disable-xv
--disable-xvmc
--disable-screensaver
--enable-present
--disable-xinerama
--disable-xace
--disable-dbe
--disable-dpms
--disable-xfree86-utils
--disable-vgahw
--disable-vbe
--disable-int10-module
--disable-pciaccess
--disable-dri
--disable-dri2
--disable-dri3
--disable-input-thread
--disable-glamor
--disable-xf86vidmode
--disable-xf86bigfont
--disable-clientids
--disable-linux-acpi
--disable-linux-apm
--disable-strict-compilation
--disable-listen-tcp
--disable-listen-unix
--disable-listen-linux
--disable-visibility
--disable-xnest
--disable-xquartz
--disable-xwin
--disable-xwayland
--disable-standalone-xpbproxy
--disable-kdrive
--disable-kdrive-evdev
--disable-kdrive-kbd
--disable-xephyr
--disable-xfake
--disable-xfbdev
--disable-local-transport
--disable-secure-rpc
--enable-input-thread
--enable-xtrans-send-fds
--disable-xorg
--enable-xvfb
--disable-dmx
--enable-ipv6
--enable-tcp-transport
--enable-unix-transport
--disable-libunwind
--with-sha1=libcrypto
--with-fontrootdir=$TERMUX_PREFIX/share/fonts
--with-xkb-path=$TERMUX_PREFIX/share/X11/xkb
"
TERMUX_PKG_DEPENDS="libx11, libxfont2, libxkbfile, libxau, libpixman, openssl"

termux_step_pre_configure () {
	CFLAGS="$CFLAGS -DFNDELAY=O_NDELAY"
	if [ -n "$TERMUX_DEBUG" ]; then
		TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-debug"
	fi
}

termux_step_post_make_install () {
	rm -f "${TERMUX_PREFIX}/usr/share/X11/xkb/compiled"
}

if [ "$#" -eq 1 ] && [ "$1" == "xorg_server_flags" ]; then
        echo $TERMUX_PKG_EXTRA_CONFIGURE_ARGS
        return 
fi
