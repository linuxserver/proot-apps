ARG REPO
FROM ghcr.io/${REPO}:alpine-320 as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    ktorrent && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:ktorrent %U\"" \
    -e "s/Name=KTorrent/Name=KTorrent PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/org.kde.ktorrent.desktop && \
  mv \
    /usr/share/applications/org.kde.ktorrent.desktop \
    /usr/share/applications/ktorrent-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "ktorrent-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
