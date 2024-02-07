# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2019-2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=adguardhome
PKG_VERSION:=v0.107.44
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2024-02-06
PKG_SOURCE_VERSION:=48d1c673a97d230ea79ec5531e1639f928b7d6f7
PKG_SOURCE_URL:=https://github.com/AdguardTeam/AdGuardHome
PKG_MIRROR_HASH:=78e2768276d34c68e80b60588fc8edaff03fee6e1f359ba9940fb0ef4bf4598a

PKG_LICENSE:=GPL-3.0-only
PKG_LICENSE_FILES:=LICENSE.txt

PKG_BUILD_DEPENDS:=node-yarn/host

include ../goenv.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/adguardhome-go/Default
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Network-wide ads & trackers blocking DNS server
  URL:=https://adguard.com/adguard-home.html
  MAINTAINER:=Entware team, https://entware.net
  DEPENDS:=+ca-bundle
endef

define Package/adguardhome-go
  $(call Package/adguardhome-go/Default)
  VARIANT:=hf
endef

define Package/adguardhome-go_nohf
  $(call Package/adguardhome-go/Default)
  VARIANT:=nohf
  DEPENDS+=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/adguardhome-go/description
  AdGuard Home is a network-wide software for blocking ads and tracking.
endef

Package/adguardhome-go_nohf/description=$(Package/adguardhome-go/description)

define Package/adguardhome-go/conffiles
/opt/etc/AdGuardHome/adguardhome.conf
/opt/etc/hosts
endef

Package/adguardhome-go_nohf/conffiles=$(Package/adguardhome-go/conffiles)

GO_LDFLAGS += \
	-X '$(XIMPORTPATH)/internal/version.channel=release' \
	-X '$(XIMPORTPATH)/internal/version.version=$(PKG_VERSION)' \
	-X '$(XIMPORTPATH)/internal/version.committime=$(PKG_SOURCE_DATE)'

define Build/Web
	( cd $(PKG_BUILD_DIR); NODE_OPTIONS=--openssl-legacy-provider make js-deps js-build; )
	( cd $(PKG_BUILD_DIR); $(GO_BIN) mod tidy; )
endef

Hooks/Compile/Pre += Build/Web

define Package/adguardhome-go/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/AdGuardHome $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S99adguardhome $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/etc/AdGuardHome
	$(INSTALL_CONF) ./files/adguardhome.conf $(1)/opt/etc/AdGuardHome
	touch $(1)/opt/etc/hosts
endef

Package/adguardhome-go_nohf/install=$(Package/adguardhome-go/install)

define Package/adguardhome-go/postinst
#!/bin/sh

if [ ! -s "/opt/etc/hosts" ]; then
  cat /etc/hosts > /opt/etc/hosts
fi
endef

Package/adguardhome-go_nohf/postinst=$(Package/adguardhome-go/postinst)

$(eval $(call BuildPackage,adguardhome-go))
$(eval $(call BuildPackage,adguardhome-go_nohf))
