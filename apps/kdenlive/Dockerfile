ARG REPO
FROM ghcr.io/${REPO}:alpine-321 AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    ffplay \
    kdenlive \
    mediainfo && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:kdenlive %U\"" \
    -e "s/Name=Kdenlive/Name=Kdenlive PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/org.kde.kdenlive.desktop && \
  mv \
    /usr/share/applications/org.kde.kdenlive.desktop \
    /usr/share/applications/kdenlive-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "kdenlive-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
