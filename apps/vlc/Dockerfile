ARG REPO
FROM ghcr.io/${REPO}:alpine-321 AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    py3-wxpython \
    vlc \
    vlc-qt && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:vlc %U\"" \
    -e "s/Name=VLC media player/Name=VLC PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/vlc.desktop && \
  mv \
    /usr/share/applications/vlc.desktop \
    /usr/share/applications/vlc-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "vlc-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
