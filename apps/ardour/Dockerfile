ARG REPO
FROM ghcr.io/${REPO}:alpine-323 AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    ardour \
    ffmpeg \
    lame && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:ardour %U\"" \
    -e "s/Name=Ardour/Name=Ardour PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/ardour*.desktop && \
  mv \
    /usr/share/applications/ardour*.desktop \
    /usr/share/applications/ardour-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "ardour-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
