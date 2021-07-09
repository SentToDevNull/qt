# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

QT6_MODULE="qtlocation"
inherit qt6-build

DESCRIPTION="Physical position determination library for the Qt6 framework"

if [[ ${QT6_BUILD_TYPE} == release ]]; then
	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
fi

IUSE="geoclue +qml"

RDEPEND="
	~dev-qt/qtcore-${PV}
	geoclue? ( ~dev-qt/qtdbus-${PV} )
	qml? ( ~dev-qt/qtdeclarative-${PV} )
"
DEPEND="${RDEPEND}"
PDEPEND="
	geoclue? ( app-misc/geoclue:2.0 )
"

QT6_TARGET_SUBDIRS=(
	src/3rdparty/clipper
	src/3rdparty/poly2tri
	src/3rdparty/clip2tri
	src/positioning
	src/plugins/position/positionpoll
)

pkg_setup() {
	use geoclue && QT6_TARGET_SUBDIRS+=( src/plugins/position/geoclue2 )
	use qml && QT6_TARGET_SUBDIRS+=(
		src/positioningquick
		src/imports/positioning
	)
}
