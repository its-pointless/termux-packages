TERMUX_PKG_HOMEPAGE=https://packages.debian.org/apt
TERMUX_PKG_DESCRIPTION="Front-end for the dpkg package manager"
TERMUX_PKG_DEPENDS="libutil, gnutls, liblzma, dpkg, gpgv, libc++, termux-exec"
TERMUX_PKG_VERSION=1.6.1
TERMUX_PKG_SHA256=89ff5c6a29e550f3e96b1e9cf28ccea114965d2b5b4c008220d1625a4ca007b9
TERMUX_PKG_SRCURL=http://ftp.debian.org/debian/pool/main/a/apt/apt_${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DPERL_EXECUTABLE=`which perl`
-DCMAKE_INSTALL_FULL_LOCALSTATEDIR=$TERMUX_PREFIX
-DCOMMON_ARCH=$TERMUX_ARCH
-DDPKG_DATADIR=$TERMUX_PREFIX/share/dpkg
-DUSE_NLS=OFF
-DWITH_DOC=OFF
"
TERMUX_PKG_CONFFILES="etc/apt/sources.list etc/apt/trusted.gpg"
TERMUX_PKG_ESSENTIAL=yes
TERMUX_PKG_CONFLICTS=apt-transport-https
TERMUX_PKG_REPLACES=apt-transport-https
TERMUX_PKG_RM_AFTER_INSTALL="
bin/apt-cdrom
bin/apt-extracttemplates
bin/apt-sortpkgs
etc/apt/apt.conf.d
lib/apt/apt-helper
lib/apt/methods/bzip2
lib/apt/methods/cdrom
lib/apt/methods/mirror
lib/apt/methods/mirror+http
lib/apt/methods/mirror+https
lib/apt/methods/mirror+ftp
lib/apt/methods/mirror+file
lib/apt/methods/mirror+copy
lib/apt/methods/rred
lib/apt/methods/ftp
lib/apt/planners/
lib/apt/solvers/
lib/dpkg/
lib/libapt-inst.so
"

termux_step_pre_configure() {
	rm -rf /data/data/com.termux/files/usr/include/apt-pkg
}
termux_step_post_make_install() {
    cp $TERMUX_PKG_BUILDER_DIR/trusted.gpg $TERMUX_PREFIX/etc/apt/
       printf "# The main termux repository:\n#deb [arch=all,${TERMUX_ARCH}] https://termux.net stable main\n" >> $TERMUX_PREFIX/etc/apt/sources.list
}
