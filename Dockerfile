# syntax=docker/dockerfile:1.7
FROM ubuntu:26.04

ARG DEBIAN_FRONTEND=noninteractive
ARG EARNAPP_INSTALL_URL=https://brightdata.com/static/earnapp/install.sh
ARG EARNAPP_INSTALL_SHA256=ff6647905a43245bac71edce3d3a49bab72e0ef5a17c6a42fdebe2c14b37261e
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION=latest

LABEL org.opencontainers.image.title="earnapp-safe"       org.opencontainers.image.description="Transparent, checksum-pinned EarnApp container image"       org.opencontainers.image.source="https://github.com/acoilier/earnapp"       org.opencontainers.image.licenses="MIT"       org.opencontainers.image.created="$BUILD_DATE"       org.opencontainers.image.revision="$VCS_REF"       org.opencontainers.image.version="$VERSION"

RUN apt-get update     && apt-get install -y --no-install-recommends        ca-certificates curl bash coreutils procps iproute2 netbase     && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/earnapp

RUN set -eux;     curl -fsSL "$EARNAPP_INSTALL_URL" -o /usr/local/bin/earnapp-install;     echo "$EARNAPP_INSTALL_SHA256  /usr/local/bin/earnapp-install" | sha256sum -c -;     chmod 0755 /usr/local/bin/earnapp-install;     mkdir -p /etc/earnapp /var/log/earnapp

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY docker-curl-wrapper.sh /usr/local/bin/curl
RUN chmod 0755 /usr/local/bin/entrypoint.sh /usr/local/bin/curl

VOLUME ["/etc/earnapp"]

HEALTHCHECK --interval=60s --timeout=10s --start-period=120s --retries=3   CMD earnapp status 2>&1 | grep -q 'Current status: enabled' || exit 1

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["run"]
