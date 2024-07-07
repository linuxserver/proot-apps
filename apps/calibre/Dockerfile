ARG REPO
FROM ghcr.io/${REPO}:alpine-edge AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    calibre && \
  apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community \
    speech-dispatcher && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:calibre %U\"" \
    -e "s/Name=calibre/Name=calibre PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/calibre-gui.desktop && \
  mv \
    /usr/share/applications/calibre-gui.desktop \
    /usr/share/applications/calibre-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "calibre-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
