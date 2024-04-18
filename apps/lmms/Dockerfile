ARG REPO
FROM ghcr.io/${REPO}:alpine-319-av as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    lmms && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:lmms %U\"" \
    -e "s/Name=LMMS/Name=LMMS PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/lmms.desktop && \
  mv \
    /usr/share/applications/lmms.desktop \
    /usr/share/applications/lmms-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "lmms-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
