ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libgtk-3-bin \
    libatk1.0 \
    libatk-bridge2.0 \
    libnss3 \
    libopengl0 \
    python3-xdg && \
  OC_VERSION=$(curl -sX GET "https://api.github.com/repos/opencloud-eu/desktop/releases/latest"| awk '/tag_name/{print $4;exit}' FS='[""]') && \
  curl -o \
    /tmp/opencloud.app -L \
    "https://github.com/opencloud-eu/desktop/releases/download/${OC_VERSION}/OpenCloud_Desktop-${OC_VERSION}-linux-gcc-x86_64.AppImage" && \
  cd /tmp && \
  chmod +x /tmp/opencloud.app && \
  ./opencloud.app --appimage-extract && \
  mv squashfs-root /opt/opencloud && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:opencloud %U\"" \
    -e "s/Name=OpenCloud Desktop desktop sync client/Name=OpenCloud PA/g" \
    -e '/^TryExec=/d' \
    /opt/opencloud/opencloud.desktop && \
  mv \
    /opt/opencloud/opencloud.desktop \
    /usr/share/applications/opencloud-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "opencloud-pa" > /bin-name && \
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
