ARG REPO
FROM ghcr.io/${REPO}:alpine-320 AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    blender && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:blender %U\"" \
    -e "s/Name=Blender/Name=Blender PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/blender.desktop && \
  mv \
    /usr/share/applications/blender.desktop \
    /usr/share/applications/blender-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "blender-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
