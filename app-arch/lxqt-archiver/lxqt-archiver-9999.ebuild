# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake xdg-utils

DESCRIPTION="A Simple and Lightweight Qt File Archiver"
HOMEPAGE="https://lxqt.org/"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lxqt/${PN}.git"
else
	SRC_URI="https://github.com/lxqt/${PN}/releases/download/${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"

BDEPEND="
	dev-qt/linguist-tools:6
	>=dev-util/lxqt-build-tools-0.6.0
"
RDEPEND="
	dev-libs/json-glib
	dev-qt/qtcore:6
	dev-qt/qtdbus:6
	dev-qt/qtgui:6
	dev-qt/qtwidgets:6
	dev-qt/qtx11extras:6
	>=x11-libs/libfm-qt-0.14.0
"
DEPEND="${RDEPEND}"

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
