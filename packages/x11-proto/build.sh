TERMUX_PKG_HOMEPAGE=https://www.x.org
TERMUX_PKG_VERSION=1.19.1
TERMUX_PKG_NO_DEVELSPLIT=true
TERMUX_PKG_PLATFORM_INDEPENDENT=true
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_DEPENDS="xorg-macros"

termux_step_post_extract_package () {
	# not required: dmxproto
	export _PROTOS=(xf86dgaproto-2.1 xproto-7.0.31 xextproto-7.3.0 xcmiscproto-1.2.2 randrproto-1.5.0 renderproto-0.11.1 bigreqsproto-1.1.2 compositeproto-0.4.2 fixesproto-5.0 fontsproto-2.1.3 damageproto-1.2.1 glproto-1.4.17 inputproto-2.3.2 kbproto-1.0.7 resourceproto-1.2.0 dmxproto-2.3.1 presentproto-1.1 recordproto-1.14.2 xineramaproto-1.2.1 dri2proto-2.8)
export _SHASUMS=('ac5ef65108e1f2146286e53080975683dae49fc94680042e04bd1e2010e99050' \
		 'c6f9747da0bd3a95f86b17fb8dd5e717c8f3ab7f0ece3ba1b247899ec1ef7747' \
		 'f3f4b23ac8db9c3a9e0d8edb591713f3d70ef9c3b175970dd8823dfc92aa5bb0' \
		 'b13236869372256c36db79ae39d54214172677fb79e9cdc555dceec80bd9d2df' \
		 '4c675533e79cd730997d232c8894b6692174dce58d3e207021b8f860be498468' \
		 '06735a5b92b20759204e4751ecd6064a2ad8a6246bb65b3078b862a00def2537' \
		 '462116ab44e41d8121bfde947321950370b285a5316612b8fce8334d50751b1e' \
		 '049359f0be0b2b984a8149c966dd04e8c58e6eade2a4a309cf1126635ccd0cfc' \
		 'ba2f3f31246bdd3f2a0acf8bd3b09ba99cab965c7fb2c2c92b7dc72870e424ce' \
		 '259046b0dd9130825c4a4c479ba3591d6d0f17a33f54e294b56478729a6e5ab8' \
		 '5c7c112e9b9ea8a9d5b019e5f17d481ae20f766cb7a4648360e7c1b46fc9fc5b' \
		 'adaa94bded310a2bfcbb9deb4d751d965fcfe6fb3a2f6d242e2df2d6589dbe40' \
		 '893a6af55733262058a27b38eeb1edc733669f01d404e8581b167f03c03ef31d' \
		 'f882210b76376e3fa006b11dbd890e56ec0942bc56e65d1249ff4af86f90b857' \
		 '3c66003a6bdeb0f70932a9ed3cf57cc554234154378d301e0c5cfa189d8f6818' \
		 'e72051e6a3e06b236d19eed56368117b745ca1e1a27bdc50fd51aa375bea6509' \
		 'f69b23a8869f78a5898aaf53938b829c8165e597cda34f06024d43ee1e6d26b9' \
		 'a777548d2e92aa259f1528de3c4a36d15e07a4650d0976573a8e2ff5437e7370' \
		 '977574bb3dc192ecd9c55f59f991ec1dff340be3e31392c95deff423da52485b' \
		 'f9b55476def44fc7c459b2537d17dbc731e36ed5d416af7ca0b1e2e676f8aa04')
cd $TERMUX_PKG_SRCDIR
for index in {0..19} 
	do
		file="${_PROTOS[$index]}.tar.bz2"
		shasum="${_SHASUMS[$index]}"
		test ! -f $TERMUX_PKG_CACHEDIR/$file && termux_download https://www.x.org/archive/individual/proto/$file $TERMUX_PKG_CACHEDIR/$file $shasum
		tar xf $TERMUX_PKG_CACHEDIR/$file
	done
}

termux_step_configure () {
    for index in {0..19}
	do
		dir="${_PROTOS[$index]}"
		cd $TERMUX_PKG_SRCDIR/$dir
		./configure --prefix $TERMUX_PREFIX --host $TERMUX_HOST_PLATFORM
		make install
	done
}
