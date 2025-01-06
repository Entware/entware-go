# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2020-2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=yggdrasil-go
PKG_VERSION:=0.5.12
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/yggdrasil-network/yggdrasil-go
PKG_MIRROR_HASH:=52653522b1f5a0d1187908c9c76574f095ad1a7e889e4641dd85129b37daeea2

PKG_LICENSE:=LGPL-3.0-only
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_PARALLEL:=1

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
	DEPENDS:=@arm
endef

define Package/yggdrasil-go/description
  Yggdrasil builds end-to-end encrypted networks with IPv6.
  Beyond the similarities with cjdns is a different routing algorithm.
  This globally-agreed spanning tree uses greedy routing in a metric space.
  Back-pressure routing techniques allow advanced link aggregation bonding
  on per-stream basis. In turn, a single stream will span across multiple
  network interfaces simultaneously with much greater throughput.
endef

Package/yggdrasil-go_nohf/description=$(Package/yggdrasil-go/description)

GO_LDFLAGS += \
	-X '$(XIMPORTPATH)/src/version.buildName=yggdrasil-entware' \
	-X '$(XIMPORTPATH)/src/version.buildVersion=$(PKG_VERSION)'

GO_TARGET:=./cmd/yggdrasil ./cmd/yggdrasilctl

define Package/yggdrasil-go/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/yggdrasil{,ctl} $(1)/opt/sbin
endef

Package/yggdrasil-go_nohf/install=$(Package/yggdrasil-go/install)

$(eval $(call BuildPackage,yggdrasil-go))
$(eval $(call BuildPackage,yggdrasil-go_nohf))
