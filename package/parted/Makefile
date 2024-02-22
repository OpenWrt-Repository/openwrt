#
# Copyright (C) 2019 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=parted
PKG_VERSION:=3.6
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=http://ftp.gnu.org/gnu/parted/
PKG_HASH:=3b43dbe33cca0f9a18601ebab56b7852b128ec1a3df3a9b30ccde5e73359e612

include $(INCLUDE_DIR)/package.mk
define Package/parted
	SECTION:=utils
	CATEGORY:=Utilities
	SUBMENU:=Disc
	TITLE:=parted Partition editor
	URL:=http://www.gnu.org/software/parted/index.shtml
	DEPENDS:= +libuuid +libreadline +libncurses +libblkid
endef

define Package/parted/description
	parted Partition editor
	http://www.gnu.org/software/parted/index.shtml
endef

define Build/Configure
	$(call Build/Configure/Default, \
		--without-readline \
		--disable-device-mapper \
		--disable-nls \
	)
endef

define Package/parted/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/libparted/.libs/*.so* $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/libparted/fs/.libs/*.so* $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/parted/.libs/parted $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/partprobe/.libs/partprobe $(1)/usr/sbin/
endef

$(eval $(call BuildPackage,parted))