#
# Copyright (C) 2011-2021 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# The newer version has different dependency tracking

include $(TOPDIR)/rules.mk

PKG_NAME:=yggdrasil-go
PKG_VERSION:=0.4.7
PKG_RELEASE:=1

PKG_GOGET:=github.com/yggdrasil-network/yggdrasil-go

PKG_SOURCE_VERSION:=14f1cd4696a37b0f7fdcb067fac337c46953f8af

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://$(PKG_GOGET)
PKG_MIRROR_HASH:=ce8ac6fe3ee42ce77c51ae5b624da98965d13e911672e62484c4f4a5a4e53a58

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/yggdrasil-go/Default
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Routing and Redirection
	TITLE:=Encrypted IPv6 network
	URL:=https://yggdrasil-network.github.io/
	MAINTAINER:=Entware team, https://entware.net
endef

define Package/yggdrasil-go
	$(call Package/yggdrasil-go/Default)
	VARIANT:=hf
endef

define Package/yggdrasil-go_nohf
	$(call Package/yggdrasil-go/Default)
	VARIANT:=nohf
	DEPENDS:=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/yggdrasil-go/description
  Yggdrasil builds end-to-end encrypted networks with IPv6.
  Beyond the similarities with cjdns is a different routing
  algorithm. This globally-agreed spanning tree uses greedy
  routing in a metric space. Back-pressure routing techniques
  allow advanced link aggregation bonding on per-stream basis.
  In turn, a single stream will span across multiple network
  interfaces simultaneously with much greater throughput.
endef

Package/yggdrasil-go_nohf/description=$(Package/yggdrasil-go/description)

GO_LDFLAGS += \
	-X '$(PKG_GOGET)/src/version.buildName=yggdrasil-entware' \
	-X '$(PKG_GOGET)/src/version.buildVersion=$(PKG_VERSION)'

GO_TARGET:=./cmd/yggdrasil ./cmd/yggdrasilctl

define Package/yggdrasil-go/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(GO_INSTALL_DIR)/yggdrasil{,ctl} $(1)/opt/sbin
endef

Package/yggdrasil-go_nohf/install=$(Package/yggdrasil-go/install)

$(eval $(call BuildPackage,yggdrasil-go))
$(eval $(call BuildPackage,yggdrasil-go_nohf))
