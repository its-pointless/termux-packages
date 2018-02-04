TERMUX_PKG_HOMEPAGE=https://www.rust-lang.org
TERMUX_PKG_DEPENDS="clang"
TERMUX_PKG_VERSION=1.23.0
#TERMUX_PKG_SHA256=80ee9ecc1e03ee63ea13c2612b61fc04fce9240476836f70c553ebaebd58fed6
TERMUX_PKG_SHA256=7196032371b50dd5582465b3bfa79ffd783b74f0711420d99b61b26c96fb3d80
TERMUX_PKG_SRCURL=https://static.rust-lang.org/dist/rustc-$TERMUX_PKG_VERSION-src.tar.xz
TERMUX_PKG_DESCRIPTION="A safe, concurrent, practical language."
TERMUX_PKG_MAINTAINER="@its-pointless"
TERMUX_PKG_KEEP_SHARE_DOC=true
# --disable-jemalloc --enable-clang --enable-llvm-link-shared --disable-option-checking
RLS_VERSION=0.123.1
TERMUX_PKG_REVISION=1

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-option-checking
--enable-clang
--disable-optimize-tests
--disable-debuginfo-tests
--disable-codegen-tests
--enable-local-rust
--enable-local-rebuild
--enable-llvm-link-shared
"
#TERMUX_PKG_CLANG=no
termux_step_pre_configure () {
	termux_setup_cmake
	termux_setup_rust
	rustup target add $RUST_TARGET_TRIPLE
	RUST_BACKTRACE=1
	GCCT=$(which $CC)
	GCCP=$(which $CXX)
	mkdir -p $TERMUX_PKG_TMPDIR/lib/pkgconfig
	mkdir -p $TERMUX_PKG_TMPDIR/include
	mkdir -p $TERMUX_PKG_TMPDIR/bin

	cp $TERMUX_PREFIX/lib/libc++_shared.so $TERMUX_PKG_TMPDIR/lib
	cp $TERMUX_PREFIX/lib/libssl.* $TERMUX_PKG_TMPDIR/lib
	cp $TERMUX_PREFIX/lib/libcrypto.* $TERMUX_PKG_TMPDIR/lib
	cp -rf  $TERMUX_PREFIX/include/openssl $TERMUX_PKG_TMPDIR/include
	cp $TERMUX_PREFIX/lib/pkgconfig/libcrypto.pc $TERMUX_PKG_TMPDIR/lib/pkgconfig
	cp $TERMUX_PREFIX/lib/pkgconfig/libssl.pc $TERMUX_PKG_TMPDIR/lib/pkgconfig
	if [ $TERMUX_ARCH != "x86_64" ]; then
	    cp $TERMUX_STANDALONE_TOOLCHAIN/sysroot/usr/lib/libz.so $TERMUX_PKG_TMPDIR/lib
	fi
	# most configuration is done with this file
	export RUST_BACKTRACE=1	
	export PATH=$TERMUX_PKG_TMPDIR/bin:$PATH
	echo "$GCCT -L$TERMUX_PKG_TMPDIR/lib -I$TERMUX_PKG_TMPDIR/include \$@" > $TERMUX_PKG_TMPDIR/bin/$CC
	echo "$GCCP -L$TERMUX_PKG_TMPDIR/lib -I$TERMUX_PKG_TMPDIR/include \$@" > $TERMUX_PKG_TMPDIR/bin/$CXX
	chmod +x $TERMUX_PKG_TMPDIR/bin/$CC
	chmod +x $TERMUX_PKG_TMPDIR/bin/$CXX
	if [ $TERMUX_ARCH = "aarch64" ]; then
		CARCH="AARCH64"
	elif [ $TERMUX_ARCH = "i686" ]; then
		CARCH=I686
	else CARCH=X86_64
	fi
	if [ $TERMUX_ARCH = "arm" ]; then          
		export CARCH=ARMV7
		export LDFLAGS_armv7_linux_androideabi="$LDFLAGS"
		export CFLAGS_armv7_linux_androideabi="$CFLAGS"
		export CXXFLAGS_armv7_linux_androideabi="$CXXFLAGS"
		export LD_armv7_linux_androideabi="$LD"
		export RANLIB_${TERMUX_ARCH}_linux_android="$RANLIB"	
	else
		export LDFLAGS_${TERMUX_ARCH}_linux_android="-L$TERMUX_PKG_BUILDDIR/build/$RUST_TARGET_TRIPLE/llvm/lib -lLLVMCo"
		export CFLAGS_${TERMUX_ARCH}_linux_android="$CFLAGS" # -L$TERMUX_PKG_BUILDDIR/build/$RUST_TARGET_TRIPLE/llvm/lib -lLLVMCore"
		export RANLIB_${TERMUX_ARCH}_linux_android="$RANLIB"
		export LD_${TERMUX_ARCH}_linux_android="$CC"
		export CXXFLAGS_${TERMUX_ARCH}_linux_android="$CXXFLAGS" #	-L$TERMUX_PKG_BUILDDIR/build/$RUST_TARGET_TRIPLE/llvm/lib -lLLMCore"
	fi
	# x86_64 fails to build full documentation due to build system libs being linked. 
	
	export ${CARCH}_LINUX_ANDROID_OPENSSL_INCLUDE_DIR=$TERMUX_PKG_TMPDIR/include
	export ${CARCH}_LINUX_ANDROID_OPENSSL_LIB_DIR=$TERMUX_PKG_TMPDIR/lib
	if [ $CARCH = "ARMV7" ]; then
		export ARMV7_LINUX_ANDROIDEABI_OPENSSL_LIB_DIR=$TERMUX_PKG_TMPDIR/lib
		export ARMV7_LINUX_ANDROIDEABI_OPENSSL_INCLUDE_DIR=$TERMUX_PKG_TMPDIR/include
	fi
	export PKG_CONFIG_PATH=$TERMUX_PKG_TMPDIR/lib/pkgconfig
	cp $TERMUX_PREFIX/include/libssh2* $TERMUX_PKG_TMPDIR/include
	cp $TERMUX_PREFIX/lib/libssh2* $TERMUX_PKG_TMPDIR/lib
	cp $TERMUX_PREFIX/lib/pkgconfig/libssh2.pc  $TERMUX_PKG_TMPDIR/lib/pkgconfig
	if [ $TERMUX_ARCH = "x86_64" ]; then
		sed $TERMUX_PKG_BUILDER_DIR/config.tomlx86_64 \
			-e "s|@TERMUX_PREFIX@|$TERMUX_PREFIX|g" \
			-e "s|@TERMUX_HOST_PLATFORM@|$TERMUX_HOST_PLATFORM|g" \
			-e "s|@RUST_TARGET_TRIPLE@|$RUST_TARGET_TRIPLE|g" \
			-e "s|@RUSTC@|$(which rustc)|g" \
			-e "s|@CARGO@|$(which cargo)|g" > $TERMUX_PKG_BUILDDIR/config.toml
		cp $TERMUX_STANDALONE_TOOLCHAIN/sysroot/usr/lib64/libz.so $TERMUX_PKG_TMPDIR/lib
	else
		sed $TERMUX_PKG_BUILDER_DIR/config.toml \
                        -e "s|@TERMUX_PREFIX@|$TERMUX_PREFIX|g" \
                        -e "s|@TERMUX_HOST_PLATFORM@|$TERMUX_HOST_PLATFORM|g" \
                        -e "s|@RUST_TARGET_TRIPLE@|$RUST_TARGET_TRIPLE|g" \
			-e "s|@RUSTC@|$(which rustc)|g" \
			-e "s|@CARGO@|$(which cargo)|g" > $TERMUX_PKG_BUILDDIR/config.toml
	fi
	cp $TERMUX_PKG_BUILDDIR/config.toml $TERMUX_PKG_TMPDIR
	_CC=$CC	
	unset CFLAGS CXXFLAGS LDFLAGS CC CXX LD CPP CPPFLAGS PREFIX PKG_CONFIG_PATH 
	export _arch_args="--host=$RUST_TARGET_TRIPLE --target=$RUST_TARGET_TRIPLE"
	TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" $_arch_args --local-rust-root=$RUSTUP_HOME"
	set > ~/rustc_setb4make
}

termux_step_make () {
	mv config.toml config.oldtok
	cp $TERMUX_PKG_TMPDIR/config.toml config.toml
../src/x.py build ../src/src/llvm --host $RUST_TARGET_TRIPLE --target $RUST_TARGET_TRIPLE --target wasm32-unknown-unknown 
#if [ $TERMUX_ARCH = "i686" ] || [ $TERMUX_ARCH = "x86_64" ]; then
#echo "$GCCT $TERMUX_PKG_BUILDDIR/build/$RUST_TARGET_TRIPLE/llvm/lib -lLLVMCore-L$TERMUX_PKG_TMPDIR/lib \$@" > $TERMUX_PKG_TMPDIR/bin/$_CC
#fi
export LD_LIBRARY_PATH="/home/builder/.termux-build/rustc/build/build/x86_64-unknown-linux-gnu/stage2/lib"
#	make
#	make dist # CFG_TARGET=$RUST_TARGET_TRIPLE  CFG_HOST=$RUST_TARGET_TRIPLE
if [ $TERMUX_ARCH = "x86_64" ] ; then
	../src/x.py dist --host $RUST_TARGET_TRIPLE --target $RUST_TARGET_TRIPLE  || ../src/x.py dist --host $RUST_TARGET_TRIPLE --target $RUST_TARGET_TRIPLE  || ../src/x.py dist --host $RUST_TARGET_TRIPLE --target $RUST_TARGET_TRIPLE ||  ../src/x.py build --stage 2 ../src/src/tools/rustdoc --target x86_64-unknown-linux-gnu  --host x86_64-unknown-linux-gnu && ../src/x.py dist --host $RUST_TARGET_TRIPLE --target $RUST_TARGET_TRIPLE
	else
	../src/x.py dist --host $RUST_TARGET_TRIPLE --target $RUST_TARGET_TRIPLE || ../src/x.py dist --host $RUST_TARGET_TRIPLE --target $RUST_TARGET_TRIPLE || ../src/x.py dist --host $RUST_TARGET_TRIPLE --target $RUST_TARGET_TRIPLE 
	fi
}

termux_step_make_install () {
	mkdir -p $TERMUX_PKG_BUILDDIR/install
	if [ $TERMUX_ARCH = "x86_64" ]; then
		for tar in rustc rust-std; do
                	tar -xf $TERMUX_PKG_BUILDDIR/build/dist/$tar-$TERMUX_PKG_VERSION-$RUST_TARGET_TRIPLE.tar.gz -C $TERMUX_PKG_BUILDDIR/install
                	# uninstall previous version
                	$TERMUX_PKG_BUILDDIR/install/$tar-$TERMUX_PKG_VERSION-$RUST_TARGET_TRIPLE/install.sh --uninstall --prefix=$TERMUX_PREFIX || true
                	$TERMUX_PKG_BUILDDIR/install/$tar-$TERMUX_PKG_VERSION-$RUST_TARGET_TRIPLE/install.sh --prefix=$TERMUX_PREFIX
		done
#rls-0.123.1-aarch64-linux-android.tar.gz
		tar -xf $TERMUX_PKG_BUILDDIR/build/dist/rls-$RLS_VERSION-$RUST_TARGET_TRIPLE.tar.gz -C $TERMUX_PKG_BUILDDIR/install
		 $TERMUX_PKG_BUILDDIR/install/rls-$RLS_VERSION-$RUST_TARGET_TRIPLE/install.sh --uninstall --prefix=$TERMUX_PREFIX || true
		  $TERMUX_PKG_BUILDDIR/install/rls-$RLS_VERSION-$RUST_TARGET_TRIPLE/install.sh  --prefix=$TERMUX_PREFIX 

	else
	for tar in rustc rust-docs rust-std; do
		tar -xf $TERMUX_PKG_BUILDDIR/build/dist/$tar-$TERMUX_PKG_VERSION-$RUST_TARGET_TRIPLE.tar.gz -C $TERMUX_PKG_BUILDDIR/install
		# uninstall previous version
		$TERMUX_PKG_BUILDDIR/install/$tar-$TERMUX_PKG_VERSION-$RUST_TARGET_TRIPLE/install.sh --uninstall --prefix=$TERMUX_PREFIX || true
		$TERMUX_PKG_BUILDDIR/install/$tar-$TERMUX_PKG_VERSION-$RUST_TARGET_TRIPLE/install.sh --prefix=$TERMUX_PREFIX
	done
		tar -xf $TERMUX_PKG_BUILDDIR/build/dist/rls-$RLS_VERSION-$RUST_TARGET_TRIPLE.tar.gz -C $TERMUX_PKG_BUILDDIR/install
                 $TERMUX_PKG_BUILDDIR/install/rls-$RLS_VERSION-$RUST_TARGET_TRIPLE/install.sh --uninstall --prefix=$TERMUX_PREFIX || true
                  $TERMUX_PKG_BUILDDIR/install/rls-$RLS_VERSION-$RUST_TARGET_TRIPLE/install.sh  --prefix=$TERMUX_PREFIX
	fi
	cd "$TERMUX_PREFIX/lib"
	ln -sf rustlib/$RUST_TARGET_TRIPLE/lib/*.so .
}

termux_step_post_massage () {
	rm $TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/lib/rustlib/{components,rust-installer-version,install.log,uninstall.sh}
}
