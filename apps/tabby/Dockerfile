ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  ARCH=$(uname -m| sed 's/x86_64/x64/g'| sed 's/aarch64/arm64/') && \
  TABBY_VERSION=$(curl -sX GET "https://api.github.com/repos/Eugeny/tabby/releases/latest" \
  | awk '/tag_name/{print $4;exit}' FS='[""]') && \
  curl -o \
    /tmp/tabby.deb -L \
    "https://github.com/Eugeny/tabby/releases/download/${TABBY_VERSION}/tabby-$(echo ${TABBY_VERSION}|sed 's/^v//g')-linux-${ARCH}.deb" && \
  apt install -y --no-install-recommends \
    /tmp/tabby.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:tabby %U\"" \
    -e "s/Name=Tabby/Name=Tabby PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/tabby.desktop && \
  mv \
    /usr/share/applications/tabby.desktop \
    /usr/share/applications/tabby-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "tabby-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  apt-get autoclean && \
  rm -rf \
    /root/.cache \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
