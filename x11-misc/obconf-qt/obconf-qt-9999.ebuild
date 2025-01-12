# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake xdg-utils

DESCRIPTION="Openbox window manager configuration tool"
HOMEPAGE="https://lxqt.org/"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lxqt/${PN}.git"
else
	SRC_URI="https://downloads.lxqt.org/downloads/${PN}/${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="GPL-2+"
SLOT="0"

BDEPEND="
	dev-qt/linguist-tools:6
	>=dev-util/lxqt-build-tools-0.6.0
	sys-apps/sed
	virtual/pkgconfig
"
RDEPEND="
	dev-libs/glib:2
	dev-qt/qtcore:6
	dev-qt/qtgui:6
	dev-qt/qtwidgets:6
	dev-qt/qtx11extras:6
	x11-wm/openbox:3
	x11-libs/libX11
"
DEPEND="${RDEPEND}"

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
