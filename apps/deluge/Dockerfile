ARG REPO
FROM ghcr.io/${REPO}:alpine-320 AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    deluge-gtk \
    kde-gtk-config && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:deluge %U\"" \
    -e "s/Name=Deluge/Name=Deluge PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/deluge.desktop && \
  mv \
    /usr/share/applications/deluge.desktop \
    /usr/share/applications/deluge-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "deluge-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
