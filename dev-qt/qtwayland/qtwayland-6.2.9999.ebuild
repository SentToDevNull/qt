# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qt6-build

DESCRIPTION="Wayland platform plugin for Qt"

if [[ ${QT6_BUILD_TYPE} == release ]]; then
	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
fi

IUSE="vulkan X"

DEPEND="
	dev-libs/wayland
	~dev-qt/qtcore-${PV}:6=
	~dev-qt/qtdeclarative-${PV}:6=
	~dev-qt/qtgui-${PV}:6=[egl,libinput,vulkan=]
	media-libs/mesa[egl]
	>=x11-libs/libxkbcommon-0.2.0
	vulkan? ( dev-util/vulkan-headers )
	X? (
		~dev-qt/qtgui-${PV}[-gles2-only]
		x11-libs/libX11
		x11-libs/libXcomposite
	)
"
RDEPEND="${DEPEND}"

src_configure() {
	local myqmakeargs=(
		--
		$(qt_use vulkan feature-wayland-vulkan-server-buffer)
		$(qt_use X feature-xcomposite-egl)
		$(qt_use X feature-xcomposite-glx)
	)
	qt6-build_src_configure
}
