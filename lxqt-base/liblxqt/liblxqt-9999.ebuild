# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Common base library for the LXQt desktop environment"
HOMEPAGE="https://lxqt.org/"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lxqt/${PN}.git"
else
	SRC_URI="https://downloads.lxqt.org/downloads/${PN}/${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="LGPL-2.1+ BSD"
SLOT="0/$(ver_cut 1-2)"
IUSE="+backlight"

BDEPEND="
	dev-qt/linguist-tools:6
	>=dev-util/lxqt-build-tools-0.6.0
"
RDEPEND="
	>=dev-libs/libqtxdg-3.3.1
	dev-qt/qtcore:6
	dev-qt/qtdbus:6
	dev-qt/qtgui:6
	dev-qt/qtwidgets:6
	dev-qt/qtx11extras:6
	dev-qt/qtxml:6
	kde-frameworks/kwindowsystem:5[X]
	x11-libs/libX11
	x11-libs/libXScrnSaver
"
DEPEND="${RDEPEND}
	backlight? ( sys-auth/polkit-qt )
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_BACKLIGHT_LINUX_BACKEND=$(usex backlight)
	)
	cmake_src_configure
}
