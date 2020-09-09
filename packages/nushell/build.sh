TERMUX_PKG_HOMEPAGE=https://www.nushell.sh
TERMUX_PKG_DESCRIPTION="A new type of shell operating on structured data"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_VERSION=0.19.0
TERMUX_PKG_SRCURL=https://github.com/nushell/nushell/archive/$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=18aefc280a51b2202daca4c5c27aa166f5c0049ebef16d9206fdd88616e8b2a0
TERMUX_PKG_DEPENDS="zlib, openssl"
TERMUX_PKG_BUILD_IN_SRC=true
termux_step_pre_configure() {
	CFLAGS=""
}
if [ TERMUX_ARCH = "x86_64" ]; then
termux_step_make_install() {
	termux_setup_rust
	unset LDFLAGS RUSTFLAGS
	cp $PREFIX/lib/libssl.so.1.1 $TERMUX_STANDALONE_TOOLCHAIN/sysroot/usr/lib/$TERMUX_HOST_PLATFORM/$TERMUX_PKG_API_LEVEL/libssl.so
	cp $PREFIX/lib/libcrypto.so.1.1 $TERMUX_STANDALONE_TOOLCHAIN/sysroot/usr/lib/$TERMUX_HOST_PLATFORM/$TERMUX_PKG_API_LEVEL/libcrypto.so
	mv $TERMUX_PREFIX ${TERMUX_PREFIX}a
	
	cargo install --path .
	mv ${TERMUX_PREFIX}a  $TERMUX_PREFIX
	cargo install \
		  --path . \
		  --target $CARGO_TARGET_NAME \
		  --root $TERMUX_PREFIX \
		  $TERMUX_PKG_EXTRA_CONFIGURE_ARGS 
	rm $TERMUX_STANDALONE_TOOLCHAIN/sysroot/usr/lib/$TERMUX_HOST_PLATFORM/$TERMUX_PKG_API_LEVEL/libssl.so 
	rm $TERMUX_STANDALONE_TOOLCHAIN/sysroot/usr/lib/$TERMUX_HOST_PLATFORM/$TERMUX_PKG_API_LEVEL/libcrypto.so
}
fi
