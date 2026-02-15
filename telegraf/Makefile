# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2021-2026 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=telegraf
PKG_VERSION:=1.37.1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=3352c0d56e70ee8e60e5e1db7fe94a236a27ce45
PKG_SOURCE_URL:=https://github.com/influxdata/telegraf
PKG_MIRROR_HASH:=2bc78feb582c7c032ec30a46fd44ec45937d613144e7f44ad44c658e18fb80bc

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Entware team, https://entware.net

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/telegraf/Default
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=server agent to help you collect metrics
  URL:=https://www.influxdata.com/time-series-platform/telegraf
  PROVIDES:=telegraf
endef

define Package/telegraf
  $(call Package/telegraf/Default)
  VARIANT:=hf
  DEFAULT_VARIANT:=1
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
