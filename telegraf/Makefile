#
# Copyright (C) 2011-2021 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# The newer version has different dependency tracking

include $(TOPDIR)/rules.mk

PKG_NAME:=telegraf
PKG_VERSION:=1.25.2
PKG_RELEASE:=1

PKG_GOGET:=github.com/influxdata/telegraf

PKG_SOURCE_VERSION:=67c08c519349c4ec563ce3fce437e4cb93e78482

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://$(PKG_GOGET)
PKG_MIRROR_HASH:=0b8feb905ac17ec5a7bc800221446e4552597e961b07079b431cb9742d1796fa

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
	DEPENDS:=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/telegraf/description
 Telegraf is an agent for collecting, processing, aggregating, and writing metrics.
 Design goals are to have a minimal memory footprint with a plugin system so that
 developers in the community can easily add support for collecting metrics.
endef

Package/telegraf_nohf/description=$(Package/telegraf/description)

COMMIT:=$(shell echo $(PKG_SOURCE_VERSION) | cut -b -9)

GO_LDFLAGS += \
	-X '$(PKG_GOGET)/internal.Commit=$(COMMIT)' \
	-X '$(PKG_GOGET)/internal.Branch=master' \
	-X '$(PKG_GOGET)/internal.Version=$(PKG_VERSION)'

GO_TARGET:=./cmd/telegraf

GO_VARS += GO111MODULE=on

define Package/telegraf/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/telegraf $(1)/opt/bin
endef

Package/telegraf_nohf/install=$(Package/telegraf/install)

$(eval $(call BuildPackage,telegraf))
$(eval $(call BuildPackage,telegraf_nohf))
