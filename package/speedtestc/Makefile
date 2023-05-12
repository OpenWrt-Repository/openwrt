

include $(TOPDIR)/rules.mk

PKG_NAME:=speedtestc
PKG_RELEASE:=1

PKG_SOURCE_URL:=https://github.com/mobrembski/SpeedTestC.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2020-08-20
PKG_SOURCE_VERSION:=5bd807bc32269321e500a7e7d36b8ec3fefa5f47

include $(INCLUDE_DIR)/package.mk

define Package/speedtestc
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Client for SpeedTest.net infrastructure
	URL:=https://github.com/mobrembski/SpeedTestC
	DEPENDS:=+libopenssl +libpthread
endef

#define Build/Prepare
#    $(call Build/Prepare/Default)
#    $(CP) ./src/Makefile $(PKG_BUILD_DIR)/
#endef

define Package/speedtestc/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/SpeedTestC $(1)/usr/sbin/
endef

$(eval $(call BuildPackage,speedtestc))
