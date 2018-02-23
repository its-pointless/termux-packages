TERMUX_PKG_HOMEPAGE=https://github.com/twaik
TERMUX_PKG_VERSION=0.2
TERMUX_PKG_SHA256=bde5ca8a6778a8be99370b35453eca92c8283c2987016a3d8ea6eddbad0c3f0e
TERMUX_PKG_PLATFORM_INDEPENDENT=yes
TERMUX_PKG_BUILD_IN_SRC=yes

termux_step_extract_package() {
	mkdir -p "$TERMUX_PKG_SRCDIR"
	cp -r $TERMUX_PKG_BUILDER_DIR/src/* $TERMUX_PKG_SRCDIR
}

termux_step_make () {
	export ANDROID_HOME
	./gradlew :app:assembleRelease
}

termux_step_make_install () {
	cp $TERMUX_PKG_SRCDIR/am-libexec-packaged $TERMUX_PREFIX/bin/view-test
	cp $TERMUX_PKG_SRCDIR/app/build/intermediates/cmake/release/obj/armeabi-v7a/libsanangeles.so $TERMUX_PREFIX/lib/
	mkdir -p $TERMUX_PREFIX/libexec/termux-view-test
	cp $TERMUX_PKG_SRCDIR/app/build/intermediates/cmake/release/obj/armeabi-v7a/libsanangeles.so $TERMUX_PREFIX/lib/
	cp $TERMUX_PKG_SRCDIR/app/build/outputs/apk/release/app-armeabi-v7a-release-unsigned.apk $TERMUX_PREFIX/libexec/termux-view-test/test.apk
}
