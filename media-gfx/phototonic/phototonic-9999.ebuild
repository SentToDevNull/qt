# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils xdg-utils

DESCRIPTION="Image viewer and organizer"
HOMEPAGE="https://github.com/oferkv/phototonic"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/oferkv/phototonic.git"
else
	SRC_URI="https://github.com/oferkv/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3+"
SLOT="0"
IUSE="svg tiff"

RDEPEND="
	dev-qt/qtcore:6
	dev-qt/qtgui:6
	dev-qt/qtwidgets:6
	media-gfx/exiv2:=
	svg? ( dev-qt/qtsvg:6 )
	tiff? ( dev-qt/qtimageformats:6 )
"
DEPEND="${RDEPEND}"

src_configure() {
	eqmake6
}

src_install() {
	emake install INSTALL_ROOT="${D}"
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
