ARG REPO
FROM ghcr.io/${REPO}:alpine-319-av as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    retroarch && \
  apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
    $(apk search --no-cache -q --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/ libretro-* | awk '/^libretro-/' | awk '! /libretro-database/' | tr '\n' ' ') && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:retroarch %U\"" \
    -e "s/Name=RetroArch/Name=RetroArch PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/retroarch.desktop && \
  mv \
    /usr/share/applications/retroarch.desktop \
    /usr/share/applications/retroarch-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "retroarch-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
