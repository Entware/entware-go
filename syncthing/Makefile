#
# Copyright (C) 2011-2021 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=syncthing
PKG_VERSION:=1.23.2-rc.1
PKG_RELEASE:=1

PKG_GOGET:=github.com/syncthing/syncthing

PKG_SOURCE_VERSION:=a8533b269d80bbe68ea48e247ddc3f53eec52ab8

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://$(PKG_GOGET)
PKG_MIRROR_HASH:=skip

PKG_BUILD_DEPENDS:=node/host

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
	DEPENDS:=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/syncthing/description
 Syncthing replaces proprietary sync and cloud services with something open,
 trustworthy and decentralized. Your data is your data alone and you deserve
 to choose where it is stored, if it is shared with some third party and how
 it's transmitted over the Internet.
endef

Package/syncthing_nohf/description=$(Package/syncthing/description)

GO_LDFLAGS += \
	-X '$(PKG_GOGET)/lib/build.Version=v$(PKG_VERSION)' \
	-X '$(PKG_GOGET)/lib/build.Stamp=$(SOURCE_DATE_EPOCH)' \
	-X '$(PKG_GOGET)/lib/build.User=Entware' \
	-X '$(PKG_GOGET)/lib/build.Host=Entware' \
	-X '$(PKG_GOGET)/lib/build.Tags=noupgrade'

GO_VARS += \
	GO111MODULE=on \
	PATH="$(GOROOT)/bin:$$$$PATH"

GO_TAGS:=-tags=noupgrade

GO_TARGET:=./cmd/syncthing

define Build/FixAssets
	( cd $(GO_SRC_DIR); \
		PATH="$(GOROOT)/bin:$$$$PATH" \
		$(GO_BIN) run build.go assets; \
	)
endef

Hooks/Compile/Pre += Build/FixAssets

define Package/syncthing/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(GO_INSTALL_DIR)/$(PKG_NAME) $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) files/S92syncthing $(1)/opt/etc/init.d
endef

Package/syncthing_nohf/install=$(Package/syncthing/install)

$(eval $(call BuildPackage,syncthing))
$(eval $(call BuildPackage,syncthing_nohf))
