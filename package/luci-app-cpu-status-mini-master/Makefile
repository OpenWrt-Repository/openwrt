#
# Copyright (C) 2021 gSpot (https://github.com/gSpotx2f/luci-app-cpu-status-mini)
#
# This is free software, licensed under the MIT License.
#

include $(TOPDIR)/rules.mk

PKG_VERSION:=0.1
PKG_RELEASE:=1
LUCI_TITLE:=CPU utilization info for the LuCI status page
LUCI_DEPENDS:=+luci-mod-admin-full
LUCI_PKGARCH:=all
PKG_LICENSE:=MIT

include $(TOPDIR)/feeds/luci/luci.mk

define Package/luci-app-cpu-status-mini/postinst
#!/bin/sh
rm -rf /tmp/luci-indexcache
rm -rf /tmp/luci-modulecache/
exit 0
endef

# call BuildPackage - OpenWrt buildroot signature
