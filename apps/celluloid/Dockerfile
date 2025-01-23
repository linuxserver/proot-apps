ARG REPO
FROM ghcr.io/${REPO}:alpine-321 AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    celluloid && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:celluloid %U\"" \
    -e "s/Name=Celluloid/Name=Celluloid PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/io.github.celluloid_player.Celluloid.desktop && \
  mv \
    /usr/share/applications/io.github.celluloid_player.Celluloid.desktop \
    /usr/share/applications/celluloid-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "celluloid-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
