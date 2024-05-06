ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  FLYCAST_VERSION=$(curl -sX GET "https://api.github.com/repos/flyinghead/flycast/releases/latest" \
    | awk '/tag_name/{print $4;exit}' FS='[""]') && \
  curl -o \
    /tmp/flycast.app -L \
    "https://github.com/flyinghead/flycast/releases/download/${FLYCAST_VERSION}/flycast-x86_64.AppImage" && \
  chmod +x /tmp/flycast.app && \
  cd /tmp && \
  ./flycast.app --appimage-extract && \
  mv squashfs-root /opt/flycast && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:flycast %U\"" \
    -e "s/Name=Flycast/Name=Flycast PA/g" \
    -e '/^TryExec=/d' \
    /opt/flycast/flycast.desktop && \
  mv \
    /opt/flycast/flycast.desktop \
    /usr/share/applications/flycast-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "flycast-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  apt-get autoclean && \
  rm -rf \
    /root/.cache \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
