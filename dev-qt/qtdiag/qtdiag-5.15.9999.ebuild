# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

QT6_MODULE="qttools"
inherit qt6-build

DESCRIPTION="Tool for reporting diagnostic information about Qt and its environment"

if [[ ${QT6_BUILD_TYPE} == release ]]; then
	KEYWORDS="~amd64 ~arm ~hppa ~ppc64 ~sparc ~x86"
fi

IUSE="+network +widgets"

RDEPEND="
	~dev-qt/qtcore-${PV}:6=
	~dev-qt/qtgui-${PV}:6=
	network? ( ~dev-qt/qtnetwork-${PV}[ssl] )
	widgets? ( ~dev-qt/qtwidgets-${PV} )
"
# TODO: we know it is bogus, figure out how to disable checks, bug 728278
DEPEND="${RDEPEND}
	~dev-qt/qtxml-${PV}
"

src_prepare() {
	qt_use_disable_mod network network \
		src/qtdiag/qtdiag.pro

	qt_use_disable_mod widgets widgets \
		src/qtdiag/qtdiag.pro

	qt6-build_src_prepare
}
