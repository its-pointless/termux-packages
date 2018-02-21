TERMUX_PKG_HOMEPAGE=https://www.libsdl.org
TERMUX_PKG_DESCRIPTION="Simple DirectMedia Layer is a cross-platform development library "
TERMUX_PKG_VERSION=1.2.15
TERMUX_PKG_SRCURL=https://www.libsdl.org/release/SDL-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=d6d316a793e5e348155f0dd93b979798933fb98aa1edebcc108829d6474aad00
TERMUX_PKG_DEPENDS="xorg-server, libpulseaudio, libx11, libdbus, libxcb, libflac, libxau, libsm, libuuid"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--with-x"
