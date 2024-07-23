# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2021-2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=telegraf
PKG_VERSION:=1.31.1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=99fcdc283bdca2bb00c1fa8c59172a69d9c2137d
PKG_SOURCE_URL:=https://github.com/influxdata/telegraf
PKG_MIRROR_HASH:=6563774cb00d8055c658fdbd277e7eced8ab9dda9241739e2e32d98586f6ff61

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/telegraf/Default
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=an agent for collecting, processing, aggregating, writing metrics
	URL:=https://github.com/influxdata/telegraf
	MAINTAINER:=Entware team, https://entware.net
endef

define Package/telegraf
	$(call Package/telegraf/Default)
	VARIANT:=hf
endef

define Package/telegraf_nohf
	$(call Package/telegraf/Default)
	VARIANT:=nohf
	DEPENDS:=@arm
endef

define Package/telegraf/description
 Telegraf is an agent for collecting, processing, aggregating, and writing metrics.
 Design goals are to have a minimal memory footprint with a plugin system so that
 developers in the community can easily add support for collecting metrics.
endef

Package/telegraf_nohf/description=$(Package/telegraf/description)

GO_LDFLAGS += \
	-X '$(XIMPORTPATH)/internal.Commit=$(COMMIT_SHORT)' \
	-X '$(XIMPORTPATH)/internal.Branch=master' \
	-X '$(XIMPORTPATH)/internal.Version=$(PKG_VERSION)'

GO_TARGET:=./cmd/telegraf

GO_VARS += GO111MODULE=on

define Package/telegraf/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/telegraf $(1)/opt/bin
endef

Package/telegraf_nohf/install=$(Package/telegraf/install)

$(eval $(call BuildPackage,telegraf))
$(eval $(call BuildPackage,telegraf_nohf))
