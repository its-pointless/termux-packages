TERMUX_PKG_HOMEPAGE=http://invisible-island.net/xterm
TERMUX_PKG_VERSION=327
TERMUX_PKG_SRCURL=ftp://invisible-island.net/xterm/xterm-$TERMUX_PKG_VERSION.tgz
TERMUX_PKG_SHA256=66fb2f6c35b342148f549c276b12a3aa3fb408e27ab6360ddec513e14376150b
TERMUX_PKG_DEPENDS="libxaw, ncurses, libxkbfile"
TERMUX_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="cf_cv_have_utmp=no ac_cv_header_pty_h=no ac_cv_func_grantpt=yes --disable-openpty --disable-pty-handshake --disable-setuid --disable-setgid --disable-luit"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure () {
	if [ -n "$TERMUX_DEBUG" ]; then
		TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-trace"
	fi
	CFLAGS="$CFLAGS -DUSE_POSIX_TERMIOS=1 -DCANT_OPEN_DEV_TTY -DUSE_USG_PTYS -DHAVE_GRANTPT_PTY_ISATTY"
}
