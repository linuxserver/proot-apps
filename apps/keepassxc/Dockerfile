ARG REPO
FROM ghcr.io/${REPO}:alpine-323 AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    keepassxc && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:keepassxc %U\"" \
    -e "s/Name=KeePassXC/Name=KeePassXC PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/org.keepassxc.KeePassXC.desktop && \
  mv \
    /usr/share/applications/org.keepassxc.KeePassXC.desktop \
    /usr/share/applications/keepassxc-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "keepassxc-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
