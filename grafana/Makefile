#
# Copyright (C) 2023 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=grafana
PKG_VERSION:=10.0.3
PKG_RELEASE:=1
SOURCE_DATE:=2023-07-26

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=eb8dd7263774270427606573496c748c8c1fec2d
PKG_SOURCE_URL:=https://github.com/grafana/grafana
PKG_MIRROR_HASH:=25407f5ceb6fbeb2ab6ba5eb12aa90b6970a6836547265451c3c68c56402e693

PKG_LICENSE:=AGPL-3.0-only
PKG_LICENSE_FILES:=LICENSE LICENSING.md

PKG_CGO_ENABLED:=1
PKG_BUILD_DEPENDS:=node-yarn/host

include ../goenv.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/grafana/Default
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=prometheus tools
  TITLE:=platform for monitoring and observability
  URL:=https://grafana.com
  MAINTAINER:=Entware team, https://entware.net
endef

define Package/grafana
  $(call Package/grafana/Default)
  VARIANT:=hf
endef

define Package/grafana_nohf
  $(call Package/grafana/Default)
  VARIANT:=nohf
  DEPENDS:=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/grafana/description
  The open and composable observability and data visualization
  platform. Visualize metrics, logs, and traces from multiple
  sources like Prometheus, Loki, Elasticsearch, InfluxDB, Postgres
  and many more. 
endef

Package/grafana_nohf/description=$(Package/grafana/description)

GO_LDFLAGS += \
	-X 'main.version=$(PKG_VERSION)' \
	-X 'main.commit=$(COMMIT_SHORT)' \
	-X 'main.buildstamp=$(SOURCE_DATE)' \
	-X 'main.buildBranch=main'

GO_TARGET:=./pkg/cmd/grafana ./pkg/cmd/grafana-cli ./pkg/cmd/grafana-server

define Build/Deps
	# install frontend dependencies
	( cd $(PKG_BUILD_DIR); \
		YARN_ENABLE_PROGRESS_BARS=false YARN_CHECKSUM_BEHAVIOR=update \
		yarn install --immutable; \
	)
	# wire-host
	( cd $(PKG_BUILD_DIR)/.bingo; \
		GOWORK=off $(GO_BIN) build -mod=mod -modfile=wire.mod \
		-o=$(PKG_BUILD_DIR)/wire-host "github.com/google/wire/cmd/wire"; \
	)
	# generate code from .cue files
	( cd $(PKG_BUILD_DIR); \
		$(GO_BIN) generate ./pkg/plugins/plugindef; \
		$(GO_BIN) generate ./kinds/gen.go; \
		$(GO_BIN) generate ./public/app/plugins/gen.go; \
		$(GO_BIN) generate ./pkg/kindsysreport/codegen/report.go; \
	)
	# generate go files
	( cd $(PKG_BUILD_DIR); \
		PATH="$(GOROOT)/bin:$(PATH)" \
		$(PKG_BUILD_DIR)/wire-host gen -tags "oss" ./pkg/server; \
	)
endef

Hooks/Compile/Pre += Build/Deps

define Build/Web
	# build frontend
	# FIXME JavaScript heap out of memory
	( cd $(PKG_BUILD_DIR); \
		NODE_OPTIONS=--max_old_space_size=8000 yarn run build; \
	)
	( cd $(PKG_BUILD_DIR)/plugins-bundled/internal/input-datasource; \
		yarn run build; \
	)
endef

Hooks/Compile/Post += Build/Web

define Package/grafana/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/grafana{,-cli,-server} $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/grafana
	$(CP) $(PKG_BUILD_DIR)/conf/sample.ini $(1)/opt/etc/grafana/grafana.ini
	$(CP) $(PKG_BUILD_DIR)/conf/ldap.toml $(1)/opt/etc/grafana
	$(CP) $(PKG_BUILD_DIR)/conf/provisioning $(1)/opt/etc/grafana
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S80grafana $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/share/grafana
	$(CP) $(PKG_BUILD_DIR)/{conf,public} $(1)/opt/share/grafana
	$(INSTALL_DIR) $(1)/opt/share/grafana/plugins-bundled/internal/input-datasource
	$(CP) $(PKG_BUILD_DIR)/plugins-bundled/internal/input-datasource/dist/* \
		$(1)/opt/share/grafana/plugins-bundled/internal/input-datasource
	# XXX remove *.map
	$(FIND) $(1)/opt/share/grafana -type f -a -iname "*.map" -delete
	$(INSTALL_DIR) $(1)/opt/var/lib/grafana/plugins
	$(INSTALL_DIR) $(1)/opt/var/log/grafana
endef

Package/grafana_nohf/install=$(Package/grafana/install)

$(eval $(call BuildPackage,grafana))
$(eval $(call BuildPackage,grafana_nohf))
