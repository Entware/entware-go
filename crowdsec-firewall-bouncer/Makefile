# SPDX-License-Identifier: MIT
#
# Copyright (C) 2021-2022 Gerald Kerma <gandalf@gk2.net>
# Copyright (C) 2026 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=crowdsec-firewall-bouncer
PKG_VERSION:=0.0.36
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/crowdsecurity/cs-firewall-bouncer/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=46c41cce09df0be41ca091499fffd3ca2e61f85fb66e4f82060043e0894290cf

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Entware team, https://entware.net

PKG_BUILD_DIR:=$(BUILD_DIR)/$(if $(BUILD_VARIANT),$(PKG_NAME)-$(BUILD_VARIANT)/)cs-firewall-bouncer-$(PKG_VERSION)
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/crowdsec-firewall-bouncer/Default
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Firewall bouncer for CrowdSec
  URL:=https://github.com/crowdsecurity/cs-firewall-bouncer
  DEPENDS:=+ca-bundle
  PROVIDES:=crowdsec-firewall-bouncer
endef

define Package/crowdsec-firewall-bouncer
  $(call Package/crowdsec-firewall-bouncer/Default)
  VARIANT:=hf
  DEFAULT_VARIANT:=1
endef

define Package/crowdsec-firewall-bouncer_nohf
  $(call Package/crowdsec-firewall-bouncer/Default)
  VARIANT:=nohf
  DEPENDS+=@arm
endef

define Package/crowdsec-firewall-bouncer/conffiles
/opt/etc/crowdsec/bouncers/crowdsec-firewall-bouncer.yaml
endef

Package/crowdsec-firewall-bouncer_nohf/conffiles=$(Package/crowdsec-firewall-bouncer/conffiles)

GO_LDFLAGS += -X 'github.com/crowdsecurity/go-cs-lib/version.Version=v$(PKG_VERSION)'

define Package/crowdsec-firewall-bouncer/install
	$(INSTALL_DIR) $(1)/opt/bin $(1)/opt/etc/crowdsec/bouncers
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/cs-firewall-bouncer $(1)/opt/bin/crowdsec-firewall-bouncer
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/config/crowdsec-firewall-bouncer.yaml $(1)/opt/etc/crowdsec/bouncers/
endef

Package/crowdsec-firewall-bouncer_nohf/install=$(Package/crowdsec-firewall-bouncer/install)

$(eval $(call BuildPackage,crowdsec-firewall-bouncer))
$(eval $(call BuildPackage,crowdsec-firewall-bouncer_nohf))
