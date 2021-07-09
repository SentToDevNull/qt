# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

QT6_MODULE="qttools"
inherit qt6-build

DESCRIPTION="Interface to Qt applications communicating over D-Bus"

if [[ ${QT6_BUILD_TYPE} == release ]]; then
	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
fi

IUSE=""

DEPEND="
	~dev-qt/qtcore-${PV}
	~dev-qt/qtdbus-${PV}
	~dev-qt/qtxml-${PV}
"
RDEPEND="${DEPEND}"

QT6_TARGET_SUBDIRS=(
	src/qdbus/qdbus
)
