include $(TOPDIR)/rules.mk

PKG_NAME:=mkexfat
PKG_VERSION:=0.1
PKG_RELEASE:=1

PKG_MAINTAINER:=hyphop

PKG_SOURCE_PROTO:=git
PKG_REV:=798d2501e6d9dce0d58800380fce77a8c54c7280
PKG_SOURCE_URL:=https://github.com/relan/exfat
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_REV).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)

PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

#MAKE_PATH:=./src

define Package/mkexfat
    SECTION:=utils
    CATEGORY:=Utilities
    TITLE:=mkexfat
endef
#    DEPENDS:=+libfuse


#MAKE_FLAGS += \
#	INCLUDEFLAGS="$(TARGET_LDFLAGS)" \
#	LINKFLAGS="$(TARGET_LDFLAGS)"

define Package/mkexfat/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(CP) $(PKG_BUILD_DIR)/mkfs/mkexfatfs $(1)/usr/sbin
endef

$(eval $(call BuildPackage,mkexfat))
