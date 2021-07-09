# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qt6-build

DESCRIPTION="Location (places, maps, navigation) library for the Qt6 framework"

if [[ ${QT6_BUILD_TYPE} == release ]]; then
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

IUSE=""

RDEPEND="
	dev-libs/icu:=
	~dev-qt/qtcore-${PV}
	~dev-qt/qtdeclarative-${PV}
	~dev-qt/qtgui-${PV}
	~dev-qt/qtnetwork-${PV}
	~dev-qt/qtpositioning-${PV}[qml]
	~dev-qt/qtsql-${PV}
	sys-libs/zlib
"
DEPEND="${RDEPEND}
	~dev-qt/qtconcurrent-${PV}
"

QT6_TARGET_SUBDIRS=(
	src/3rdparty/clipper
	src/3rdparty/poly2tri
	src/3rdparty/clip2tri
	src/3rdparty/mapbox-gl-native
	src/location
	src/imports/location
	src/imports/locationlabs
	src/plugins/geoservices
)

src_configure() {
	# src/plugins/geoservices requires files that are only generated when
	# qmake is run in the root directory. Bug 633776.
	mkdir -p "${QT6_BUILD_DIR}"/src/location || die
	qt6_qmake "${QT6_BUILD_DIR}"
	cp "${S}"/src/location/qtlocation-config.pri "${QT6_BUILD_DIR}"/src/location || die
	qt6-build_src_configure
}
