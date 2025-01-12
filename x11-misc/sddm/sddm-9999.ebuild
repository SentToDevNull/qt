# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
else
	SRC_URI="https://github.com/${PN}/${PN}/releases/download/v${PV}/${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"
fi

PLOCALES="ar bn ca cs da de es et fi fr hi_IN hu ie is it ja kk ko lt lv nb nl nn pl pt_BR pt_PT ro ru sk sr sr@ijekavian sr@ijekavianlatin sr@latin sv tr uk zh_CN zh_TW"
inherit cmake l10n systemd user

DESCRIPTION="Simple Desktop Display Manager"
HOMEPAGE="https://github.com/sddm/sddm"

LICENSE="GPL-2+ MIT CC-BY-3.0 CC-BY-SA-3.0 public-domain"
SLOT="0"
IUSE="elogind +pam systemd test"

REQUIRED_USE="?? ( elogind systemd )"

RESTRICT="!test? ( test )"

BDEPEND="
	dev-python/docutils
	>=dev-qt/linguist-tools-6.2.0:6
	kde-frameworks/extra-cmake-modules:5
	virtual/pkgconfig
"
RDEPEND="
	>=dev-qt/qtcore-6.2.0:6
	>=dev-qt/qtdbus-6.2.0:6
	>=dev-qt/qtdeclarative-6.2.0:6
	>=dev-qt/qtgui-6.2.0:6
	>=dev-qt/qtnetwork-6.2.0:6
	>=x11-base/xorg-server-1.15.1
	x11-libs/libxcb[xkb]
	elogind? ( sys-auth/elogind )
	pam? ( sys-libs/pam )
	systemd? ( sys-apps/systemd:= )
	!systemd? ( sys-power/upower )
"
DEPEND="${RDEPEND}
	test? ( >=dev-qt/qttest-6.2.0:6 )
"

PATCHES=(
	# Pending upstream
	# fix for groups: https://github.com/sddm/sddm/issues/1159
	"${FILESDIR}"/${PN}-0.18.1-revert-honor-PAM-supplemental-groups.patch
	"${FILESDIR}"/${PN}-0.18.1-honor-PAM-supplemental-groups-v2.patch
	# Downstream patches
	"${FILESDIR}"/${PN}-0.18.1-respect-user-flags.patch # bug 563108
	"${FILESDIR}"/${PN}-0.19.0-Xsession.patch # bug 611210
)

src_prepare() {
	cmake_src_prepare

	disable_locale() {
		sed -e "/${1}\.ts/d" -i data/translations/CMakeLists.txt || die
	}
	l10n_find_plocales_changes "data/translations" "" ".ts"
	l10n_for_each_disabled_locale_do disable_locale

	if ! use test; then
		sed -e "/^find_package/s/ Test//" -i CMakeLists.txt || die
		cmake_comment_add_subdirectory test
	fi
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_PAM=$(usex pam)
		-DNO_SYSTEMD=$(usex '!systemd')
		-DUSE_ELOGIND=$(usex 'elogind')
		-DBUILD_MAN_PAGES=ON
		-DDBUS_CONFIG_FILENAME="org.freedesktop.sddm.conf"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	# Create a default.conf as upstream dropped /etc/sddm.conf w/o replacement
	local confd="/usr/lib/sddm/sddm.conf.d"
	dodir ${confd}
	"${D}"/usr/bin/sddm --example-config > "${D}/${confd}"/00default.conf \
		|| die "Failed to create 00default.conf"

	sed -e "/^InputMethod/s/qtvirtualkeyboard//" \
		-e "/^ReuseSession/s/false/true/" \
		-e "/^EnableHiDPI/s/false/true/" \
		-i "${D}/${confd}"/00default.conf || die
}

pkg_postinst() {
	elog "Starting with 0.18.0, SDDM no longer installs /etc/sddm.conf"
	elog "Use it to override specific options. SDDM defaults are now"
	elog "found in: /usr/lib/sddm/sddm.conf.d/00default.conf"

	enewgroup ${PN}
	enewuser ${PN} -1 -1 /var/lib/${PN} ${PN},video

	systemd_reenable sddm.service
}
