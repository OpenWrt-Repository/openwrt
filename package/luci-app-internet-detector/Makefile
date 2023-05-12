#
# Copyright (C) 2020 gSpot (https://github.com/gSpotx2f/luci-app-internet-detector)
#
# This is free software, licensed under the MIT License.
#

include $(TOPDIR)/rules.mk

PKG_VERSION:=0.2
PKG_RELEASE:=1
LUCI_TITLE:=Internet detector for the LuCI status page
LUCI_DEPENDS:=+luci-mod-admin-full
LUCI_PKGARCH:=all
PKG_LICENSE:=MIT

include $(TOPDIR)/feeds/luci/luci.mk

define Package/luci-app-internet-detector/postinst
#!/bin/sh
rm -rf /tmp/luci-indexcache
rm -rf /tmp/luci-modulecache/
exit 0
endef

# call BuildPackage - OpenWrt buildroot signature
