# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="LXQt quick launcher"
HOMEPAGE="https://lxqt.org/"

MY_PV="$(ver_cut 1-2)*"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lxqt/${PN}.git"
else
	SRC_URI="https://downloads.lxqt.org/downloads/${PN}/${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="LGPL-2.1+"
SLOT="0"

BDEPEND="
	dev-qt/linguist-tools:6
	>=dev-util/lxqt-build-tools-0.6.0
	virtual/pkgconfig
"
RDEPEND="
	>=dev-cpp/muParser-2.2.3:=
	>=dev-libs/libqtxdg-3.3.1
	dev-qt/qtcore:6
	dev-qt/qtgui:6
	dev-qt/qtwidgets:6
	dev-qt/qtxml:6
	kde-frameworks/kwindowsystem:5
	>=lxde-base/menu-cache-0.5.1
	=lxqt-base/liblxqt-${MY_PV}
	=lxqt-base/lxqt-globalkeys-${MY_PV}
"
DEPEND="${RDEPEND}"

src_install(){
	cmake_src_install
	doman man/*.1
}
