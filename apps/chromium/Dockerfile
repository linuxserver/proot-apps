ARG REPO
FROM ghcr.io/${REPO}:alpine-320 as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    chromium && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:chromium %U\"" \
    -e "s/Name=Chromium/Name=Chromium PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/chromium.desktop && \
  mv \
    /usr/share/applications/chromium.desktop \
    /usr/share/applications/chromium-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "chromium-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
