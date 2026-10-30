ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libegl1 \
    libgl1 \
    libopengl0 \
    libwayland-cursor0 \
    libwayland-egl1 \
    libx11-6 \
    libx11-xcb1 \
    libxcb-cursor0 \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-randr0 \
    libxcb-render-util0 \
    libxcb-shape0 \
    libxcb-sync1 \
    libxcb-xfixes0 \
    libxcb-xkb1 \
    libxkbcommon-x11-0 \
    libxkbcommon0 && \
  INGETRAZO_VERSION=$(curl -sX GET "https://api.github.com/repos/ingelibre/ingetrazo/releases/latest" \
    | jq -r '.tag_name') && \
  curl -o \
    /tmp/ingetrazo.app -L \
    "https://github.com/ingelibre/ingetrazo/releases/download/${INGETRAZO_VERSION}/IngeTrazo-$(echo ${INGETRAZO_VERSION}| sed 's/^v//g')-x86_64.AppImage" && \
  chmod +x /tmp/ingetrazo.app && \
  cd /tmp && \
  ./ingetrazo.app --appimage-extract && \
  mv squashfs-root /opt/ingetrazo && \
  mkdir -p /usr/share/icons/hicolor/scalable/apps && \
  curl -o \
    /usr/share/icons/hicolor/scalable/apps/ingetrazo.svg -L \
    "https://raw.githubusercontent.com/ingelibre/ingetrazo/${INGETRAZO_VERSION}/resources/icons/ingetrazo.svg" && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:ingetrazo %f\"" \
    -e "s/^Name=IngeTrazo$/Name=IngeTrazo PA/g" \
    -e '/^TryExec=/d' \
    -e '/^X-AppImage-Version=/d' \
    /opt/ingetrazo/ingetrazo.desktop && \
  mv \
    /opt/ingetrazo/ingetrazo.desktop \
    /usr/share/applications/ingetrazo-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "ingetrazo-pa" > /bin-name && \
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
