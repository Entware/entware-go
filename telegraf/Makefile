# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2021-2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=telegraf
PKG_VERSION:=1.33.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=679020053079dec8aec210efe4eceaa5cad73944
PKG_SOURCE_URL:=https://github.com/influxdata/telegraf
PKG_MIRROR_HASH:=6783a5dd38df088b8e64d8207c74ad516a95bd066f062d3bd6b3e865370a3ddd

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/telegraf/Default
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=server agent to help you collect metrics
	URL:=https://www.influxdata.com/time-series-platform/telegraf
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
 Telegraf is an agent for collecting, processing, aggregating, and
 writing metrics. Design goals are to have a minimal memory footprint with a
 plugin system so that developers in the community can easily add support for
 collecting metrics.
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
