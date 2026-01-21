ARG REPO
FROM ghcr.io/${REPO}:alpine-323 AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    freeciv \
    freeciv-data && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:freeciv %U\"" \
    -e "s/Name=Firefox/Name=Firefox PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/org.freeciv.gtk322.desktop && \
  mv \
    /usr/share/applications/org.freeciv.gtk322.desktop \
    /usr/share/applications/freeciv-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "freeciv-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
