TERMUX_PKG_HOMEPAGE=https://www.x.org
TERMUX_PKG_VERSION=1.0.3
TERMUX_PKG_PLATFORM_INDEPENDENT=true
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_DEPENDS="fontutil"

_url=https://www.x.org/archive/individual/font

_font=( arabic-misc-$TERMUX_PKG_VERSION
	cursor-misc-$TERMUX_PKG_VERSION
	daewoo-misc-$TERMUX_PKG_VERSION
	dec-misc-$TERMUX_PKG_VERSION
	isas-misc-$TERMUX_PKG_VERSION
	jis-misc-$TERMUX_PKG_VERSION
	micro-misc-$TERMUX_PKG_VERSION
	misc-ethiopic-$TERMUX_PKG_VERSION
	misc-meltho-$TERMUX_PKG_VERSION
	mutt-misc-$TERMUX_PKG_VERSION
	sony-misc-$TERMUX_PKG_VERSION
	sun-misc-$TERMUX_PKG_VERSION
	misc-misc-1.1.2
	schumacher-misc-1.1.2 )

_sums=( 505d9b12a7093389e67a925dfda6346bde26d114c67f0cdca7aeda6e5d3344f4
	17363eb35eece2e08144da5f060c70103b59d0972b4f4d77fd84c9a7a2dba635
	bc65de70bee12698caa95b523d3b652c056347e17b68cc8b5d6bbdff235c4be8
	e19ddf8b5f8de914d81675358fdfe37762e9ce524887cc983adef34f2850ff7b
	5824ab4b485951107dd245b8f7717d2822f1a6dbf6cea98f1ac7f49905c0a867
	2b18ce10b367ebafe95a17de799b6db9a24e2337188d124adaf68af05b1fac65
	9a3381c10f32d9511f0ad4179df395914c50779103c16cddf7017f5220ed8db6
	53cb1fd83afdbe7939c0eac34003676ee0e6023216892d98054db90b703c98a5
	3721323f13855cf7ca609115a1f7b182491e9b2b9c6e01eb1a2c7f8edd480791
	bd5f7adb34367c197773a9801df5bce7b019664941900b2a31fbfe1ff2830f8f
	2043a326ba347c9da5ca1e9bc363e2521c3ea40b43b1f9662d333efd4867cff5
	481f4fcbbf7005658b080b3cf342c8c76de752e77f47958b2b383de73266d2e0
	b8e77940e4e1769dc47ef1805918d8c9be37c708735832a07204258bacc11794
	e444028656e0767e2eddc6d9aca462b16a2be75a47244dbc199b2c44eca87e5a )

termux_step_post_extract_package () {
	for fontindex in "${!_font[@]}"; do
		file=font-${_font[fontindex]}.tar.bz2
		test ! -f $TERMUX_PKG_CACHEDIR/$file && termux_download $_url/$file $TERMUX_PKG_CACHEDIR/$file ${_sums[fontindex]}
		tar xf $TERMUX_PKG_CACHEDIR/$file -C $TERMUX_PKG_SRCDIR
		cd $TERMUX_PKG_SRCDIR/font-${_font[fontindex]}
		./configure --prefix $TERMUX_PREFIX --host $TERMUX_HOST_PLATFORM --with-fontdir=$TERMUX_PREFIX/share/fonts/misc
		make install
	done
}

termux_step_post_make_install () {
	rm -f $TERMUX_PREFIX/share/fonts/*/fonts.*
	mv $TERMUX_PREFIX/share/fonts/misc/*.otf $TERMUX_PREFIX/share/fonts/OTF/
}
