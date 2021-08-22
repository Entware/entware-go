#
# Copyright (C) 2011-2021 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# The newer version has different dependency tracking

include $(TOPDIR)/rules.mk

PKG_NAME:=telegraf
PKG_VERSION:=1.19.3
PKG_RELEASE:=1
PKG_GOGET:=github.com/influxdata/telegraf

GOPKG_SOURCE=GO_$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE).tar.bz2

#!!! uncomment PKG_SOURCE to download fixed version
PKG_SOURCE:=$(GOPKG_SOURCE)
PKG_HASH:=d96f1e5220429fc0b46870f70dfe54c03474e373c011eb29244519d2edf44377
PKG_COMMIT:=a799489ff2417bdafe2bbe03af6172174a53d13b

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

ifeq ($(BUILD_VARIANT),nohf)
GOARM=GOARM=5
endif

define Package/telegraf/Default
	$(call Package/gopackage/Default)
	TITLE:=telegraf  is an agent for collecting, processing, aggregating, and writing metrics
	URL:=https://github.com/influxdata/telegraf
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

define Build/Compile
        (\
		cd $(PKG_BUILD_DIR); \
		mkdir -p bin; \
		cd src/$(PKG_GOGET); \
		CGO_ENABLED=0 GO111MODULE=on GOOS=linux GOARCH=$(GOARCH) $(GOARM) GOPATH=$(PKG_BUILD_DIR) $(GOROOT)/bin/go build -ldflags="-X main.version=$(PKG_VERSION) -s -w" -x -v $(PKG_GOGET)/cmd/telegraf; \
		cp telegraf $(PKG_BUILD_DIR)/bin; \
		chmod -R +w $(PKG_BUILD_DIR)/pkg; \
        )
endef


define Package/telegraf/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/telegraf $(1)/opt/bin
endef

Package/telegraf_nohf/install=$(Package/telegraf/install)

$(eval $(call BuildPackage,telegraf))
$(eval $(call BuildPackage,telegraf_nohf))

