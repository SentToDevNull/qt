# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop git-r3 qmake-utils

DESCRIPTION="Feature-rich dictionary lookup program"
HOMEPAGE="http://goldendict.org/"
EGIT_REPO_URI="https://github.com/goldendict/goldendict.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="debug ffmpeg"

BDEPEND="
	dev-qt/linguist-tools:6
	virtual/pkgconfig
"
DEPEND="
	app-arch/bzip2
	>=app-text/hunspell-1.2:=
	dev-libs/eb
	dev-libs/lzo
	dev-qt/qtcore:6
	dev-qt/qtgui:6
	dev-qt/qthelp:6
	dev-qt/qtnetwork:6
	dev-qt/qtprintsupport:6
	dev-qt/qtsingleapplication[qt6(+),X]
	dev-qt/qtsvg:6
	dev-qt/qtwebkit:6
	dev-qt/qtwidgets:6
	dev-qt/qtx11extras:6
	dev-qt/qtxml:6
	media-libs/libvorbis
	media-libs/tiff:0
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXtst
	ffmpeg? (
		media-libs/libao
		media-video/ffmpeg:0=
	)
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-1.5.0-qtsingleapplication-unbundle.patch" )

src_prepare() {
	default

	# disable git
	sed -i -e '/git describe/s/^/#/' ${PN}.pro || die

	# fix installation path
	sed -i -e '/PREFIX = /s:/usr/local:/usr:' ${PN}.pro || die

	# add trailing semicolon
	sed -i -e '/^Categories/s/$/;/' redist/${PN}.desktop || die
}

src_configure() {
	local myconf=()
	use ffmpeg || myconf+=( DISABLE_INTERNAL_PLAYER=1 )

	eqmake6 "${myconf[@]}"
}

src_install() {
	dobin ${PN}
	domenu redist/${PN}.desktop
	doicon redist/icons/${PN}.png

	insinto /usr/share/apps/${PN}/locale
	doins locale/*.qm

	insinto /usr/share/${PN}/help
	doins help/*.qch
}
