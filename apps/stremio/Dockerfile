ARG REPO
FROM ghcr.io/${REPO}:ubuntu-jammy AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    hicolor-icon-theme && \
  curl -o \
    /tmp/stremio.deb -L \
    "https://dl.strem.io/shell-linux/v4.4.168/stremio_4.4.168-1_amd64.deb" && \
  curl -o \
    /tmp/libssl.deb -L \
    "http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.22_amd64.deb" && \
  dpkg -i \
    /tmp/libssl.deb && \
  mkdir -p \
    /usr/share/desktop-directories && \
  apt install -y --no-install-recommends \
    /tmp/stremio.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:stremio %U\"" \
    -e "s/Name=Stremio/Name=Stremio PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/smartcode-stremio.desktop && \
  mv \
    /usr/share/applications/smartcode-stremio.desktop \
    /usr/share/applications/stremio-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "stremio-pa" > /bin-name && \
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
