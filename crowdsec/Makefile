# SPDX-License-Identifier: MIT
#
# Copyright (C) 2021-2022 Gerald Kerma <gandalf@gk2.net>
# Copyright (C) 2026 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=crowdsec
PKG_VERSION:=1.6.2
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/crowdsecurity/crowdsec/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=5f8a4d6ebdaec0a31f6c66c8523896167be59f270b4337ce1db44f62403e7d94

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Entware team, https://entware.net

PKG_BUILD_PARALLEL:=1

PKG_CGO_ENABLED:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/crowdsec/Default
  SECTION:=net
  CATEGORY:=Network
  TITLE:=CrowdSec detection engine
  URL:=https://crowdsec.net/
  DEPENDS:=+ca-bundle +libpthread
  PROVIDES:=crowdsec
endef

define Package/crowdsec
  $(call Package/crowdsec/Default)
  VARIANT:=hf
  DEFAULT_VARIANT:=1
endef

define Package/crowdsec_nohf
  $(call Package/crowdsec/Default)
  VARIANT:=nohf
  DEPENDS+=@arm
endef

define Package/crowdsec/conffiles
/opt/etc/crowdsec/acquis.yaml
/opt/etc/crowdsec/config.yaml
/opt/etc/crowdsec/console.yaml
/opt/etc/crowdsec/dev.yaml
/opt/etc/crowdsec/local_api_credentials.yaml
/opt/etc/crowdsec/online_api_credentials.yaml
/opt/etc/crowdsec/profiles.yaml
/opt/etc/crowdsec/simulation.yaml
/opt/etc/crowdsec/user.yaml
endef

Package/crowdsec_nohf/conffiles=$(Package/crowdsec/conffiles)

GO_TARGET:=./cmd/crowdsec ./cmd/crowdsec-cli ./cmd/notification-*
GO_TAGS:=netgo,osusergo,sqlite_omit_load_extension
TARGET_CFLAGS += -D_LARGEFILE64_SOURCE
GO_LDFLAGS += \
	-X 'github.com/crowdsecurity/go-cs-lib/version.Version=v$(PKG_VERSION)' \
	-X 'github.com/crowdsecurity/go-cs-lib/version.System=entware' \
	-X 'github.com/crowdsecurity/crowdsec/pkg/csconfig.defaultConfigDir=/opt/etc/crowdsec'

define Package/crowdsec/install
	$(INSTALL_DIR) $(1)/opt/bin $(1)/opt/etc/crowdsec \
		$(1)/opt/etc/crowdsec/{acquis.d,collections,hub,notifications,postoverflows,scenarios} \
		$(1)/opt/lib/crowdsec/plugins $(1)/opt/var/lib/crowdsec/data
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/crowdsec $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/crowdsec-cli $(1)/opt/bin/cscli
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/notification-* $(1)/opt/lib/crowdsec/plugins/
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/config/{acquis,config,console,dev,local_api_credentials,online_api_credentials,profiles,simulation,user}.yaml $(1)/opt/etc/crowdsec/
	$(CP) $(PKG_BUILD_DIR)/config/patterns $(1)/opt/etc/crowdsec/
endef

Package/crowdsec_nohf/install=$(Package/crowdsec/install)

$(eval $(call BuildPackage,crowdsec))
$(eval $(call BuildPackage,crowdsec_nohf))
