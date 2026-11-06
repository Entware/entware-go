# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2019-2026 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=dnsproxy
PKG_VERSION:=v0.86.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2026-10-01
PKG_SOURCE_VERSION:=f2a42ab8563bf782c8c131b03ef2eb44569e7c9e
PKG_SOURCE_URL:=https://github.com/AdguardTeam/dnsproxy
PKG_MIRROR_HASH:=090d331ac11d38b04c8ad974af3135b3380e29df7c6b51abeb75f0211af15639

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Entware team, https://entware.net

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/dnsproxy/Default
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Simple DNS proxy with DoH, DoT, DoQ and DNSCrypt support
  URL:=https://github.com/AdguardTeam/dnsproxy
  PROVIDES:=dnsproxy
  EXTRA_DEPENDS:=ca-bundle
endef

define Package/dnsproxy
  $(call Package/dnsproxy/Default)
  VARIANT:=hf
  DEFAULT_VARIANT:=1
endef

define Package/dnsproxy_nohf
  $(call Package/dnsproxy/Default)
  VARIANT:=nohf
  DEPENDS:=@arm
endef

define Package/dnsproxy/description
  A simple DNS proxy server that supports all existing DNS protocols including
  DNS-over-TLS, DNS-over-HTTPS, DNSCrypt, and DNS-over-QUIC. Moreover, it can
  work as a DNS-over-HTTPS, DNS-over-TLS or DNS-over-QUIC server.
endef

define Package/dnsproxy/conffiles
/opt/etc/dnsproxy/dnsproxy.conf
/opt/etc/dnsproxy/config.yaml
endef

Package/dnsproxy_nohf/description=$(Package/dnsproxy/description)

GO_LDFLAGS += \
	-X '$(XIMPORTPATH)/internal/version.channel=release' \
	-X '$(XIMPORTPATH)/internal/version.version=$(PKG_VERSION)' \
	-X '$(XIMPORTPATH)/internal/version.committime=$(PKG_SOURCE_DATE)'

define Package/dnsproxy/install
  $(INSTALL_DIR) $(1)/opt/bin
  $(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/dnsproxy $(1)/opt/bin/dnsproxy
  $(INSTALL_DIR) $(1)/opt/etc/dnsproxy
  $(INSTALL_CONF) ./files/dnsproxy.conf $(1)/opt/etc/dnsproxy
  $(CP) $(PKG_BUILD_DIR)/config.dist.yaml $(1)/opt/etc/dnsproxy/config.yaml
  $(INSTALL_DIR) $(1)/opt/etc/init.d
  $(INSTALL_BIN) ./files/S09dnsproxy $(1)/opt/etc/init.d

endef

Package/dnsproxy_nohf/install=$(Package/dnsproxy/install)

$(eval $(call BuildPackage,dnsproxy))
$(eval $(call BuildPackage,dnsproxy_nohf))
