TERMUX_PKG_HOMEPAGE=https://www.x.org
TERMUX_PKG_VERSION=1.19.1
TERMUX_PKG_NO_DEVELSPLIT=true
TERMUX_PKG_PLATFORM_INDEPENDENT=true
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_post_extract_package () {
	# not required: dmxproto
	export _PROTOS=(xproto-7.0.31 xextproto-7.3.0 xcmiscproto-1.2.2 randrproto-1.5.0 renderproto-0.11.1 bigreqsproto-1.1.2 compositeproto-0.4.2 fixesproto-5.0 fontsproto-2.1.3 damageproto-1.2.1 glproto-1.4.17 inputproto-2.3.2 kbproto-1.0.7 resourceproto-1.2.0 dmxproto-2.3.1 presentproto-1.1 recordproto-1.14.2 xineramaproto-1.2.1 dri2proto-2.8)

	cd $TERMUX_PKG_SRCDIR
	for index in "${!_PROTOS[@]}"; do
		file=${_PROTOS[index]}.tar.bz2
		test ! -f $TERMUX_PKG_CACHEDIR/$file && termux_download https://www.x.org/archive/individual/proto/$file $TERMUX_PKG_CACHEDIR/$file
		tar xf $TERMUX_PKG_CACHEDIR/$file
	done
}

termux_step_configure () {
	for index in "${!_PROTOS[@]}"; do
		cd $TERMUX_PKG_SRCDIR/${_PROTOS[index]}
		./configure --prefix $TERMUX_PREFIX --host $TERMUX_HOST_PLATFORM
		make install
	done
}
