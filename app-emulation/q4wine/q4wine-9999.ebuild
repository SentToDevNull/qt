# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg cmake git-r3

# Upstream names the package PV-rX. We change that to
# PV_pX so we can use portage revisions.
MY_P=${PN}-${PV/_p/-r}

DESCRIPTION="Qt GUI configuration tool for Wine"
HOMEPAGE="https://q4wine.brezblock.org.ua/"
EGIT_REPO_URI="https://github.com/brezerk/q4wine.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

IUSE="+dbus debug +ico +iso +wineappdb"

BDEPEND="
	dev-qt/linguist-tools:6
"
DEPEND="
	dev-qt/qtcore:6
	dev-qt/qtgui:6
	dev-qt/qtnetwork:6
	dev-qt/qtsingleapplication[qt6(+),X]
	dev-qt/qtsql:6[sqlite]
	dev-qt/qtsvg:6
	dev-qt/qtwidgets:6
	dev-qt/qtxml:6
	dbus? ( dev-qt/qtdbus:6 )
	ico? ( >=media-gfx/icoutils-0.26.0 )
"
RDEPEND="${DEPEND}
	app-admin/sudo
	>=sys-apps/which-2.19
	iso? ( sys-fs/fuseiso )
"

S="${WORKDIR}"/${MY_P}

DOCS=( AUTHORS ChangeLog README )

src_configure() {
	local mycmakeargs=(
		-DDEBUG=$(usex debug ON OFF)
		-DWITH_ICOUTILS=$(usex ico ON OFF)
		-DWITH_SYSTEM_SINGLEAPP=ON
		-DWITH_WINEAPPDB=$(usex wineappdb ON OFF)
		-DUSE_BZIP2=OFF
		-DUSE_GZIP=OFF
		-DWITH_DBUS=$(usex dbus ON OFF)
	)
	cmake_src_configure
}
