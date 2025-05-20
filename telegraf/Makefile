# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2021-2025 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=telegraf
PKG_VERSION:=1.34.4
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=e7ce1e1e740b1983f86a0587ce67858bb67eb4d1
PKG_SOURCE_URL:=https://github.com/influxdata/telegraf
PKG_MIRROR_HASH:=1d7bddc89a88b811e077daf6168636ab82a617577c2014413effec9e08126c68

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
