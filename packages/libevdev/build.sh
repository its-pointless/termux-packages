TERMUX_PKG_HOMEPAGE=https://ohse.de/uwe/software/lrzsz.html
TERMUX_PKG_DESCRIPTION="Tools for zmodem/xmodem/ymodem file transfer"
TERMUX_PKG_VERSION=0.12.20
TERMUX_PKG_SRCURL=https://www.freedesktop.org/software/libevdev/libevdev-1.5.8.tar.xz
TERMUX_PKG_SHA256=6083d81e46609da8ba80cb826c02d9080764a6dec33c8267ccb7e158833d4c6d
TERMUX_PKG_BUILD_IN_SRC=yes
TERMUX_PKG_EXTRA_CONFIGURE_ARGS=""
#TERMUX_PKG_HOSTBUILD=true
termux_step_pre_configure() {
	CFLAGS+=" -Dprogram_invocation_short_name=__FILE__"
}
