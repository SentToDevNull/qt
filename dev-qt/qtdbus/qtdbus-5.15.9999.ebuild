# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

QT6_MODULE="qtbase"
inherit qt6-build

DESCRIPTION="Qt6 module for inter-process communication over the D-Bus protocol"

if [[ ${QT6_BUILD_TYPE} == release ]]; then
	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
fi

IUSE=""

DEPEND="
	~dev-qt/qtcore-${PV}:6=
	>=sys-apps/dbus-1.4.20
"
RDEPEND="${DEPEND}"

QT6_TARGET_SUBDIRS=(
	src/dbus
	src/tools/qdbusxml2cpp
	src/tools/qdbuscpp2xml
)

QT6_GENTOO_CONFIG=(
	:dbus
	:dbus-linked:
)

QT6_GENTOO_PRIVATE_CONFIG=(
	:dbus
	:dbus-linked
)

src_configure() {
	local myconf=(
		-dbus-linked
	)
	qt6-build_src_configure
}
