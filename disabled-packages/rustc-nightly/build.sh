TERMUX_PKG_HOMEPAGE=https://www.rust-lang.org
TERMUX_PKG_DEPENDS="clang"
TERMUX_PKG_VERSION=1.25
TERMUX_PKG_SHA256=f8108ff333316c789b0aef3bbc1a2fccb149db8957ee25ceb848402237206bfd
# 03/02/2018
TERMUX_PKG_SRCURL=https://static.rust-lang.org/dist/rustc-nightly-src.tar.gz
TERMUX_PKG_DESCRIPTION="rust nightly"
TERMUX_PKG_MAINTAINER="@its-pointless"
TERMUX_PKG_KEEP_SHARE_DOC=true
TERMUX_PKG_REVISION=2
RLS_VERSION=0.124.0
# --disable-jemalloc --enable-clang --enable-llvm-link-shared --disable-option-checking
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-option-checking
--enable-clang
--disable-optimize-tests
--disable-debuginfo-tests
--disable-codegen-tests
--enable-local-rust
--enable-local-rebuild "
#ac_cv_func__Unwind_Backtrace=no

#TERMUX_PKG_CLANG=no
#TERMUX_PKG_GCC7BUILD=yes
termux_step_pre_configure () {
	termux_setup_cmake
	termux_setup_rust
	rustup target add $RUST_TARGET_TRIPLE
	rustup install nightly-x86_64-unknown-linux-gnu
	RUST_BACKTRACE=1
	PATH=$RUSTUP_HOME/toolchains/nightly-x86_64-unknown-linux-gnu/bin:$PATH	
	GCCT=$(which $CC)
	GCCP=$(which $CXX)
	mkdir -p $TERMUX_PKG_TMPDIR/lib/pkgconfig
	mkdir -p $TERMUX_PKG_TMPDIR/include
	mkdir -p $TERMUX_PKG_TMPDIR/bin
	
	cp $TERMUX_PREFIX/lib/libc++_shared.so $TERMUX_PKG_TMPDIR/lib
#	ln -s $TERMUX_PKG_TMPDIR/lib/libc++_shared.so $TERMUX_PKG_TMPDIR/lib/libstdc++.so
	cp $TERMUX_PREFIX/lib/libssl.* $TERMUX_PKG_TMPDIR/lib
        cp $TERMUX_PREFIX/lib/libcrypto.* $TERMUX_PKG_TMPDIR/lib
        cp -rf  $TERMUX_PREFIX/include/openssl $TERMUX_PKG_TMPDIR/include
        cp $TERMUX_PREFIX/lib/pkgconfig/libcrypto.pc $TERMUX_PKG_TMPDIR/lib/pkgconfig
        cp $TERMUX_PREFIX/lib/pkgconfig/libssl.pc $TERMUX_PKG_TMPDIR/lib/pkgconfig
        if [ $TERMUX_ARCH != "x86_64" ]; then
            cp $TERMUX_STANDALONE_TOOLCHAIN/sysroot/usr/lib/libz.so $TERMUX_PKG_TMPDIR/lib
        fi

	# most configuration is done with this file
	RUST_PREFIX=$TERMUX_PREFIX/opt/rust-nightly
	export RUST_BACKTRACE=1	
	export PATH=$TERMUX_PKG_TMPDIR/bin:$PATH
	echo "$GCCT -L$TERMUX_PKG_TMPDIR/lib \$@" > $TERMUX_PKG_TMPDIR/bin/$CC
	echo "$GCCP -L$TERMUX_PKG_TMPDIR/lib \$@" > $TERMUX_PKG_TMPDIR/bin/$CXX
	chmod +x $TERMUX_PKG_TMPDIR/bin/$CC
	chmod +x $TERMUX_PKG_TMPDIR/bin/$CXX
	if [ $TERMUX_ARCH = "aarch64" ]; then
                CARCH="AARCH64"
        elif [ $TERMUX_ARCH = "i686" ]; then
                CARCH=I686
        else CARCH=X86_64
        fi
	if [ $TERMUX_ARCH = "arm" ]; then          
		export LDFLAGS_armv7_linux_androideabi="$LDFLAGS -L$TERMUX_PKG_BUILDDIR/build/$RUST_TARGET_TRIPLE/stage2/lib/rustlib/$RUST_TARGET_TRIPLE/lib"
		export CFLAGS_armv7_linux_androideabi="$CFLAGS"
		export CXXFLAGS_armv7_linux_androideabi="$CXXFLAGS"
		export LD_armv7_linux_androideabi="$LD"
		export ARMV7_LINUX_ANDROIDEABI_OPENSSL_LIB_DIR=$TERMUX_PKG_TMPDIR/lib
                export ARMV7_LINUX_ANDROIDEABI_OPENSSL_INCLUDE_DIR=$TERMUX_PKG_TMPDIR/include
	else #LDFLAGS_aarch64_linux_android="-L/home/builder/.termux-build/rustc-nightly/build/build/aarch64-linux-android/stage2/lib/rustlib/aarch64-linux-android/lib"
		export LDFLAGS_${TERMUX_ARCH}_linux_android="-L$TERMUX_PKG_BUILDDIR/build/$RUST_TARGET_TRIPLE/llvm/lib  -L$TERMUX_PKG_BUILDDIR/build/$RUST_TARGET_TRIPLE/stage2/lib/rustlib/$RUST_TARGET_TRIPLE/lib"
#		export CFLAGS_${TERMUX_ARCH}_linux_android="$CFLAGS $CPPFLAGS $LDFLAGS"
		export CFLAGS_${TERMUX_ARCH}_linux_android="$CFLAGS" # -L$TERMUX_PKG_BUILDDIR/build/$RUST_TARGET_TRIPLE/llvm/lib -lLLVMCore"
		export LD_${TERMUX_ARCH}_linux_android="$LD"
		export CXXFLAGS_${TERMUX_ARCH}_linux_android="$CXXFLAGS" #	-L$TERMUX_PKG_BUILDDIR/build/$RUST_TARGET_TRIPLE/llvm/lib -lLLMCore"
	fi
	# x86_64 fails to build full documentation due to build system libs being linked. 
	export ${CARCH}_LINUX_ANDROID_OPENSSL_INCLUDE_DIR=$TERMUX_PKG_TMPDIR/include
        export ${CARCH}_LINUX_ANDROID_OPENSSL_LIB_DIR=$TERMUX_PKG_TMPDIR/lib
#	if [ $CARCH = "ARMV7" ]; then
 #               export ARMV7_LINUX_ANDROIDEABI_OPENSSL_LIB_DIR=$TERMUX_PKG_TMPDIR/lib
  #              export ARMV7_LINUX_ANDROIDEABI_OPENSSL_INCLUDE_DIR=$TERMUX_PKG_TMPDIR/include
   #     fi
	export PKG_CONFIG_PATH=$TERMUX_PKG_TMPDIR/lib/pkgconfig
	cp $TERMUX_PREFIX/include/libssh2* $TERMUX_PKG_TMPDIR/include
        cp $TERMUX_PREFIX/lib/libssh2* $TERMUX_PKG_TMPDIR/lib
        cp $TERMUX_PREFIX/lib/pkgconfig/libssh2.pc  $TERMUX_PKG_TMPDIR/lib/pkgconfig

	if [ $TERMUX_ARCH = "x86_64" ]; then
		sed $TERMUX_PKG_BUILDER_DIR/config.tomlx86_64 \
			-e "s|@RUST_PREFIX@|$RUST_PREFIX|g" \
			-e "s|@TERMUX_HOST_PLATFORM@|$TERMUX_HOST_PLATFORM|g" \
			-e "s|@RUST_TARGET_TRIPLE@|$RUST_TARGET_TRIPLE|g" \
			-e "s|@RUSTC@|$(which rustc)|g" \
			-e "s|@CARGO@|$(which cargo)|g" > $TERMUX_PKG_BUILDDIR/config.toml
		cp $TERMUX_STANDALONE_TOOLCHAIN/sysroot/usr/lib64/libz.so $TERMUX_PKG_TMPDIR/lib
	    else
		sed $TERMUX_PKG_BUILDER_DIR/config.toml \
                        -e "s|@RUST_PREFIX@|$RUST_PREFIX|g" \
                        -e "s|@TERMUX_HOST_PLATFORM@|$TERMUX_HOST_PLATFORM|g" \
                        -e "s|@RUST_TARGET_TRIPLE@|$RUST_TARGET_TRIPLE|g" \
			-e "s|@RUSTC@|$(which rustc)|g" \
			-e "s|@CARGO@|$(which cargo)|g" > $TERMUX_PKG_BUILDDIR/config.toml
	fi
	cp $TERMUX_PKG_BUILDDIR/config.toml $TERMUX_PKG_TMPDIR
	_CC=$CC	
	unset CFLAGS CXXFLAGS LDFLAGS CC CXX LD CPP CPPFLAGS PREFIX
	export _arch_args="--host=$RUST_TARGET_TRIPLE --target=$RUST_TARGET_TRIPLE"
	TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" $_arch_args --local-rust-root=$RUSTUP_HOME"
}

termux_step_make () {
	mv config.toml config.toml.orig
	cp $TERMUX_PKG_TMPDIR/config.toml config.toml
	../src/x.py build ../src/src/llvm --host $RUST_TARGET_TRIPLE --target $RUST_TARGET_TRIPLE 
#if [ $TERMUX_ARCH = "i686" ] || [ $TERMUX_ARCH = "x86_64" ]; then
#echo "$GCCT -L$TERMUX_PKG_BUILDDIR/build/$RUST_TARGET_TRIPLE/llvm/lib -lLLVMCore -L$TERMUX_PKG_TMPDIR/lib \$@" > $TERMUX_PKG_TMPDIR/bin/$_CC
#fi
#../src/x.py build --host $RUST_TARGET_TRIPLE --target $RUST_TARGET_TRIPLE || ../src/x.py build --host $RUST_TARGET_TRIPLE --target $RUST_TARGET_TRIPLE || ../src/x.py build --host $RUST_TARGET_TRIPLE --target $RUST_TARGET_TRIPLE 
#../src/x.py dist --host $RUST_TARGET_TRIPLE --target $RUST_TARGET_TRIPLE || ../src/x.py dist --host $RUST_TARGET_TRIPLE --target $RUST_TARGET_TRIPLE || ../src/x.py dist --host $RUST_TARGET_TRIPLE --target $RUST_TARGET_TRIPLE
if [ $TERMUX_ARCH = "x86_64" ] ; then
	../src/x.py dist --host $RUST_TARGET_TRIPLE --target $RUST_TARGET_TRIPLE    || ../src/x.py dist --host $RUST_TARGET_TRIPLE --target $RUST_TARGET_TRIPLE   || ../src/x.py dist --host $RUST_TARGET_TRIPLE --target $RUST_TARGET_TRIPLE   ||	../src/x.py build --stage 2 ../src/src/tools/rustdoc --target x86_64-unknown-linux-gnu  --host x86_64-unknown-linux-gnu && ../src/x.py dist --host $RUST_TARGET_TRIPLE --target $RUST_TARGET_TRIPLE
else
	
../src/x.py dist --host $RUST_TARGET_TRIPLE --target $RUST_TARGET_TRIPLE   || ../src/x.py dist --host $RUST_TARGET_TRIPLE --target $RUST_TARGET_TRIPLE  || ../src/x.py dist --host $RUST_TARGET_TRIPLE --target $RUST_TARGET_TRIPLE 
fi
# ../src/x.py dist ../src/src/tools/rls --host $RUST_TARGET_TRIPLE --target $RUST_TARGET_TRIPLE

#export LD_LIBRARY_PATH="/home/builder/.termux-build/rustc/build/build/x86_64-unknown-linux-gnu/stage2/lib"
#	make
#	make dist # CFG_TARGET=$RUST_TARGET_TRIPLE  CFG_HOST=$RUST_TARGET_TRIPLE
}

termux_step_make_install () {
	mkdir -p $TERMUX_PKG_BUILDDIR/install
	if [ $TERMUX_ARCH = "x86_64" ]; then
		for tar in rustc-nightly rust-std-nightly; do
                	tar -xf $TERMUX_PKG_BUILDDIR/build/dist/$tar-$RUST_TARGET_TRIPLE.tar.gz -C $TERMUX_PKG_BUILDDIR/install
                	# uninstall previous version
                	$TERMUX_PKG_BUILDDIR/install/$tar-$RUST_TARGET_TRIPLE/install.sh --uninstall --prefix=$RUST_PREFIX || true
                	$TERMUX_PKG_BUILDDIR/install/$tar-$RUST_TARGET_TRIPLE/install.sh --prefix=$RUST_PREFIX
		done
		tar -xf $TERMUX_PKG_BUILDDIR/build/dist/rls-nightly-$RUST_TARGET_TRIPLE.tar.gz -C $TERMUX_PKG_BUILDDIR/install
                 $TERMUX_PKG_BUILDDIR/install/rls-nightly-$RUST_TARGET_TRIPLE/install.sh --uninstall --prefix=$RUST_PREFIX || true
                  $TERMUX_PKG_BUILDDIR/install/rls-nightly-$RUST_TARGET_TRIPLE/install.sh  --prefix=$RUST_PREFIX

	else
	for tar in rustc-nightly rust-docs-nightly rust-std-nightly; do
		tar -xf $TERMUX_PKG_BUILDDIR/build/dist/$tar-$RUST_TARGET_TRIPLE.tar.gz -C $TERMUX_PKG_BUILDDIR/install
		# uninstall previous version
		$TERMUX_PKG_BUILDDIR/install/$tar-$RUST_TARGET_TRIPLE/install.sh --uninstall --prefix=$RUST_PREFIX || true
		$TERMUX_PKG_BUILDDIR/install/$tar-$RUST_TARGET_TRIPLE/install.sh --prefix=$RUST_PREFIX
	done
	tar -xf $TERMUX_PKG_BUILDDIR/build/dist/rls-nightly-$RUST_TARGET_TRIPLE.tar.gz -C $TERMUX_PKG_BUILDDIR/install
                 $TERMUX_PKG_BUILDDIR/install/rls-nightly-$RUST_TARGET_TRIPLE/install.sh --uninstall --prefix=$RUST_PREFIX || true
                  $TERMUX_PKG_BUILDDIR/install/rls-nightly-$RUST_TARGET_TRIPLE/install.sh  --prefix=$RUST_PREFIX

	fi
}

termux_step_post_massage () {
	rm $TERMUX_PKG_MASSAGEDIR/$RUST_PREFIX/lib/rustlib/{components,rust-installer-version,install.log,uninstall.sh}
	mkdir -p $TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/etc/profile.d
	mkdir -p $TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/lib
	echo "#!$TERMUX_PREFIX/bin/sh" > $TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/etc/profile.d/rust-nightly.sh
	echo "export PATH=$RUST_PREFIX/bin:\$PATH" >> $TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/etc/profile.d/rust-nightly.sh
	cd $TERMUX_PKG_MASSAGEDIR/$RUST_PREFIX/lib
	ln -sf rustlib/$RUST_TARGET_TRIPLE/lib/lib*.so .
	cd $TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/lib
	ln -s ../opt/rust-nightly/lib/lib*.so .

}
termux_step_create_debscripts () {
	echo "Provides: rustc" >> control
	echo "#!$TERMUX_PREFIX/bin/sh" > postinst
	echo "echo 'source \$PREFIX/etc/profile.d/rust-nightly.sh to use nightly'" >> postinst
	echo "echo 'or export RUSTC=\$PREFIX/opt/rust-nightly/bin/rustc'" >> postinst
}

