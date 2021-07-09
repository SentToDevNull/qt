# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

QT6_MODULE="qtbase"
inherit qt6-build

DESCRIPTION="Multi-threading concurrence support library for the Qt6 framework"

if [[ ${QT6_BUILD_TYPE} == release ]]; then
	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
fi

IUSE=""

DEPEND="
	~dev-qt/qtcore-${PV}:6=
"
RDEPEND="${DEPEND}"

QT6_TARGET_SUBDIRS=(
	src/concurrent
)
