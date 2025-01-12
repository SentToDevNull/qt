# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qt6-build

DESCRIPTION="Qt module to access CAN, ModBus, and other industrial serial buses and protocols"

if [[ ${QT6_BUILD_TYPE} == release ]]; then
	KEYWORDS="~amd64 ~x86"
fi

IUSE=""

DEPEND="
	~dev-qt/qtcore-${PV}
	~dev-qt/qtnetwork-${PV}
	~dev-qt/qtserialport-${PV}
"
RDEPEND="${DEPEND}"
