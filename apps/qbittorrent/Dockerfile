ARG REPO
FROM ghcr.io/${REPO}:alpine-319-core as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    qbittorrent && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:qbittorrent %U\"" \
    -e "s/Name=qBittorrent/Name=qBittorrent PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/org.qbittorrent.qBittorrent.desktop && \
  mv \
    /usr/share/applications/org.qbittorrent.qBittorrent.desktop \
    /usr/share/applications/qbittorrent-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "qbittorrent-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
