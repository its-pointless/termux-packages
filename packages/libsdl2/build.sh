TERMUX_PKG_HOMEPAGE=https://www.libsdl.org
TERMUX_PKG_DESCRIPTION="Simple DirectMedia Layer is a cross-platform development library"
TERMUX_PKG_VERSION=2.0.7
TERMUX_PKG_SRCURL=https://www.libsdl.org/release/SDL2-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=ee35c74c4313e2eda104b14b1b86f7db84a04eeab9430d56e001cea268bf4d5e
TERMUX_PKG_EXTRA_CONFIGURE_ARGS=" ARCH=linux"
TERMUX_PKG_BUILD_IN_SRC=yes
TERMUX_PKG_DEPENDS="libdbus"
termux_step_pre_configure() {
	CPPFLAGS+=" -UANDROID -U__ANDROID__  "
}
