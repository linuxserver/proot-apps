ARG REPO
FROM ghcr.io/${REPO}:alpine-edge AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    firefox && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:firefox %U\"" \
    -e "s/Name=Firefox/Name=Firefox PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/firefox.desktop && \
  mv \
    /usr/share/applications/firefox.desktop \
    /usr/share/applications/firefox-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "firefox-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
