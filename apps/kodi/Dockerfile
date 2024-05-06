ARG REPO
FROM ghcr.io/${REPO}:alpine-319 as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    kodi && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:kodi %U\"" \
    -e "s/Name=Kodi/Name=Kodi PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/kodi.desktop && \
  mv \
    /usr/share/applications/kodi.desktop \
    /usr/share/applications/kodi-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "kodi-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
