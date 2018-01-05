TERMUX_PKG_HOMEPAGE=https://www.gnu.org/software/octave/
TERMUX_PKG_DESCRIPTION="Scientific Programming Language"
TERMUX_PKG_REVISION=12
TERMUX_PKG_VERSION=4.2.1
TERMUX_PKG_SHA256=d1771c47c1ee2cf49e3f75d64c8de8c5b2d0625b3836c62969a627792330ab58
# Use a mirror as upstream has issues:
# TERMUX_PKG_SRCURL=http://gondor.apana.org.au/~herbert/dash/files/dash-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_DEPENDS="libbz2, libxml2, pcre, openblas, liblzma, readline, libandroid-glob, libc++, libcrypt, libcurl, gnuplot, libgfortran4, fontconfig, arpack-ng, suitesparse, qrupdate, glpk, qhull, graphicsmagick++, fftw, texinfo, termux-exec"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--with-shell=$TERMUX_PREFIX/bin/sh \
--with-umfpack-libdir=$TERMUX_PREFIX/lib \
--with-cxsparse-libdir=$TERMUX_PREFIX/lib \
--disable-java \
--disable-atomic-refcount"
TERMUX_PKG_SRCURL=https://ftp.gnu.org/gnu/octave/octave-4.2.1.tar.xz
TERMUX_PKG_GFORTRAN=yes
TERMUX_PKG_BUILD_IN_SRC=yes
#TERMUX_PKG_CLANG=no
termux_step_pre_configure() {
if [ $TERMUX_ARCH = "arm" ]; then
	CFLAGS+=" -Os"
	CXXFLAGS+=" -Os"
fi
	#	autoreconf -if
	F77=$FC
	LDFLAGS+=" -lm -landroid-support -larpack -lqrupdate -landroid-glob" 
echo "" > liboctave/system/oct-passwd.cc
echo "" > liboctave/system/oct-passwd.h
echo "" > libinterp/corefcn/getpwent.cc
echo "" > libinterp/corefcn/getgrent.cc
}
termux_step_post_make_install() {
	ln -sf $TERMUX_PREFIX/lib/octave/$TERMUX_PKG_VERSION/liboctave.so $TERMUX_PREFIX/lib/liboctave.so
	ln -sf $TERMUX_PREFIX/lib/octave/$TERMUX_PKG_VERSION/liboctinterp.so $TERMUX_PREFIX/lib/liboctinterp.so
}
