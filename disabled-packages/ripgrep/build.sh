TERMUX_PKG_HOMEPAGE=https://github.com/BurntSushi/ripgrep
TERMUX_PKG_VERSION=0.7.1
TERMUX_PKG_MAINTAINER="@its-pointless"
TERMUX_PKG_SRCURL=https://github.com/BurntSushi/ripgrep/archive/0.7.1.tar.gz
TERMUX_PKG_SHA256=e010693637acebb409f3dba7caf59ef093d1894a33b14015041b8d43547665f5
#TERMUX_PKG_DEPENDS="libcurl, rustc, openssl, libssh2"
TERMUX_PKG_DESCRIPTION="ripgrep is a line-oriented search tool"
TERMUX_PKG_BUILD_IN_SRC=true
#TERMUX_PKG_REVISION=1
termux_step_pre_configure () {
	termux_setup_rust
	termux_setup_cmake

}

termux_step_make_install () {
#	mkdir -p $TERMUX_PREFIX/{bin,etc/bash_completion.d,share/man/man1,share/zsh/site-functions}
#	local _mode="release"
#	test -n "$TERMUX_DEBUG" && _mode="debug"
	cp $TERMUX_PKG_SRCDIR/target/$RUST_TARGET_TRIPLE/release/rg $TERMUX_PREFIX/bin/
	cp $TERMUX_PKG_SRCDIR/doc/rg.1 $TERMUX_PREFIX/share/man/man1/	
#	cp $TERMUX_PKG_BUILDDIR/target/$RUST_TARGET_TRIPLE/$_mode/cargo $TERMUX_PREFIX/bin/cargo
#	cp $TERMUX_PKG_SRCDIR/src/etc/cargo.bashcomp.sh $TERMUX_PREFIX/etc/bash_completion.d/cargo
#	cp $TERMUX_PKG_SRCDIR/src/etc/man/* $TERMUX_PREFIX/share/man/man1/
#	cp $TERMUX_PKG_SRCDIR/src/etc/_cargo $TERMUX_PREFIX/share/zsh/site-functions/_cargo
}
