# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="LXQT session manager"
HOMEPAGE="http://lxqt.org/"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://git.lxde.org/git/lxde/${PN}.git"
else
	SRC_URI="http://downloads.lxqt.org/lxqt/${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2 LGPL-2.1+"
SLOT="0"

CDEPEND="
	dev-qt/linguist-tools:5
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	dev-qt/qtxml:5
	~lxqt-base/liblxqt-${PV}
	>=dev-libs/libqtxdg-1.0.0
	x11-libs/libX11"
DEPEND="${CDEPEND}
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"
RDEPEND="${CDEPEND}
	~lxqt-base/lxqt-common-${PV}"

src_install(){
	cmake-utils_src_install
	doman lxqt-config-session/man/*.1 lxqt-session/man/*.1
}
