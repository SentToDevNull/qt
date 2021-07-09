# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

QT6_MODULE="qtbase"
VIRTUALX_REQUIRED="test"
inherit qt6-build

DESCRIPTION="Unit testing library for the Qt6 framework"

if [[ ${QT6_BUILD_TYPE} == release ]]; then
	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
fi

IUSE=""

RDEPEND="
	~dev-qt/qtcore-${PV}:6=
"
DEPEND="${RDEPEND}
	test? (
		~dev-qt/qtgui-${PV}
		~dev-qt/qtxml-${PV}
	)
"

QT6_TARGET_SUBDIRS=(
	src/testlib
)

QT6_GENTOO_PRIVATE_CONFIG=(
	:testlib
)
