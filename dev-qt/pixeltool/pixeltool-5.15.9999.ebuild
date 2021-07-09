# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

QT6_MODULE="qttools"
inherit qt6-build

DESCRIPTION="Qt screen magnifier"

if [[ ${QT6_BUILD_TYPE} == release ]]; then
	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc64 ~sparc ~x86"
fi

IUSE=""

DEPEND="
	~dev-qt/qtcore-${PV}:6=
	~dev-qt/qtgui-${PV}:6=
	~dev-qt/qtwidgets-${PV}
"
RDEPEND="${DEPEND}"
