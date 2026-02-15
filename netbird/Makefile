# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2024-2026 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=netbird
PKG_VERSION:=0.64.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2026-01-20
PKG_SOURCE_VERSION:=e01998815e64660ea41535cb57b9dbab3c44f83b
PKG_SOURCE_URL:=https://github.com/netbirdio/netbird
PKG_MIRROR_HASH:=4ee9398ba1f4a44938d00d313b6bc88223a7d598ec12555f1c29d8153a54e981

PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Entware team, https://entware.net

PKG_BUILD_PARALLEL:=1
# for management (and signal?)
#PKG_CGO_ENABLED:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/netbird/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=VPN
  TITLE:=A WireGuard-based mesh network (client)
  URL:=https://netbird.io/
  PROVIDES:=netbird
endef

define Package/netbird
  $(call Package/netbird/Default)
  VARIANT:=hf
  DEFAULT_VARIANT:=1
endef

define Package/netbird_nohf
  $(call Package/netbird/Default)
  VARIANT:=nohf
  DEPENDS:=@arm
endef

define Package/netbird/description
  Connect your devices into a single secure private WireGuard®-based
  mesh network with SSO/MFA and simple access controls.
endef

Package/netbird_nohf/description=$(Package/netbird/description)

define Package/netbird/conffiles
/opt/etc/netbird/config.json
/opt/etc/netbird/env
endef

Package/netbird_nohf/conffiles=$(Package/netbird/conffiles)

GO_LDFLAGS += \
	-X '$(XIMPORTPATH)/version.version=$(PKG_VERSION)' \
	-X 'main.commit=$(COMMIT_SHORT)' \
	-X 'main.date=$(PKG_SOURCE_DATE)' \
	-X 'main.builtBy=Entware'

GO_TARGET:=./client #./management ./signal

define Package/netbird/install
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S99netbird $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/etc/netbird
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/release_files/systemd/env \
		 $(1)/opt/etc/netbird
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/client $(1)/opt/sbin/netbird
#	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/management $(1)/opt/sbin/netbird-mgmt
#	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/signal $(1)/opt/sbin/netbird-signal
endef

Package/netbird_nohf/install=$(Package/netbird/install)

$(eval $(call BuildPackage,netbird))
$(eval $(call BuildPackage,netbird_nohf))
