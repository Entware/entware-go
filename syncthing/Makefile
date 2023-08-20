#
# Copyright (C) 2011-2021 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=syncthing
PKG_VERSION:=1.23.7
PKG_RELEASE:=1
SOURCE_DATE:=2023-08-09

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=97625ccc26d0919f709acc8e4b1211b485e722aa
PKG_SOURCE_URL:=https://github.com/syncthing/syncthing
PKG_MIRROR_HASH:=4c0ad1b2792e1d28b46c69bcc15b1d47ebd8de1e071b4c3eaf7d67df2ed7fe9a

PKG_BUILD_DEPENDS:=node/host

include ../goenv.mk
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
	-X '$(XIMPORTPATH)/lib/build.Version=v$(PKG_VERSION)' \
	-X '$(XIMPORTPATH)/lib/build.Stamp=$(SOURCE_DATE)' \
	-X '$(XIMPORTPATH)/lib/build.User=Entware' \
	-X '$(XIMPORTPATH)/lib/build.Host=Entware' \
	-X '$(XIMPORTPATH)/lib/build.Tags=noupgrade'

GO_VARS += \
	GO111MODULE=on \
	PATH="$(GOROOT)/bin:$(PATH)"

GO_TAGS:=-tags=noupgrade

GO_TARGET:=./cmd/syncthing

define Build/FixAssets
	( cd $(PKG_BUILD_DIR); \
		PATH="$(GOROOT)/bin:$(PATH)" \
		$(GO_BIN) run build.go assets; \
	)
endef

Hooks/Compile/Pre += Build/FixAssets

define Package/syncthing/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/$(PKG_NAME) $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S92syncthing $(1)/opt/etc/init.d
endef

Package/syncthing_nohf/install=$(Package/syncthing/install)

$(eval $(call BuildPackage,syncthing))
$(eval $(call BuildPackage,syncthing_nohf))
