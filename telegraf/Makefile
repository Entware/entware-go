# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2021-2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=telegraf
PKG_VERSION:=1.29.4
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=4441c4ed5ba88104957ce27249aaadb175f698fb
PKG_SOURCE_URL:=https://github.com/influxdata/telegraf
PKG_MIRROR_HASH:=5b2c84418d02f1c2040ae537e3fec552fef58c4289d4983ca7434066ec1ea2c5

include ../goenv.mk
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
