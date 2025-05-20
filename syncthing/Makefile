# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2016-2025 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=syncthing
PKG_VERSION:=1.29.6
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2025-05-06
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/syncthing/syncthing
PKG_MIRROR_HASH:=59b8077d9db6f312e3af10b70505e0f61c7123979e6204d41a484723d2602a88

PKG_LICENSE:=MPL-2.0
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_DEPENDS:=node/host
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/syncthing/Default
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Utility for synchronization
	URL:=https://syncthing.net/
	MAINTAINER:=Entware team, https://entware.net
endef

define Package/syncthing
	$(call Package/syncthing/Default)
	VARIANT:=hf
endef

define Package/syncthing_nohf
	$(call Package/syncthing/Default)
	VARIANT:=nohf
	DEPENDS:=@arm
endef

define Package/syncthing/description
 Syncthing replaces proprietary sync and cloud services with something open,
 trustworthy and decentralized. Your data is your data alone and you deserve
 to choose where it is stored, if it is shared with some third party and how
 it's transmitted over the Internet.
endef

Package/syncthing_nohf/description=$(Package/syncthing/description)

GO_LDFLAGS += \
	-X '$(XIMPORTPATH)/lib/build.Version=v$(PKG_VERSION)' \
	-X '$(XIMPORTPATH)/lib/build.Stamp=$(PKG_SOURCE_DATE)' \
	-X '$(XIMPORTPATH)/lib/build.User=Entware' \
	-X '$(XIMPORTPATH)/lib/build.Host=Entware' \
	-X '$(XIMPORTPATH)/lib/build.Tags=noupgrade'

GO_VARS += GO111MODULE=on

GO_TAGS:=noupgrade

GO_TARGET:=./cmd/syncthing

define Build/Web
	( cd $(PKG_BUILD_DIR); \
		PATH="$(shell $(GO_BIN) env GOROOT)/bin:$(PATH)" \
		$(GO_ENV_COMMON) $(GO_BIN) run \
		$(if $(findstring s,$(OPENWRT_VERBOSE)),-v -x) \
		build.go assets; \
	)
endef

define Build/Compile
	$(call Build/Web)
	$(call Build/Compile/Go)
endef

define Package/syncthing/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/syncthing $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S92syncthing $(1)/opt/etc/init.d
endef

Package/syncthing_nohf/install=$(Package/syncthing/install)

$(eval $(call BuildPackage,syncthing))
$(eval $(call BuildPackage,syncthing_nohf))
