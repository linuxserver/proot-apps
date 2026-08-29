ARG REPO
FROM ghcr.io/${REPO}:ubuntu-resolute AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libgl1 \
    libopengl0 \
    libpulse0 \
    libxcb-cursor0 \
    libwayland-cursor0 \
    libwayland-egl1 \
    libxkbcommon-x11-0 && \
  echo "**** install duckstation ****" && \
  DUCK_URL=$(curl -sX GET "https://api.github.com/repos/stenzek/duckstation/releases/latest" \
    | jq -er '.assets[] | select(.name == "DuckStation-x64.AppImage") | .browser_download_url') && \
  curl -o \
    /tmp/duck.app -L \
    "${DUCK_URL}" && \
  cd /tmp && \
  chmod +x duck.app && \
  ./duck.app --appimage-extract && \
  mv \
    squashfs-root \
    /opt/duckstation && \
  mkdir -p /usr/share/icons/hicolor/scalable/apps && \
  cp \
    /opt/duckstation/org.duckstation.DuckStation.png \
    /usr/share/icons/hicolor/scalable/apps/org.duckstation.DuckStation.png && \
  echo "**** create desktop file ****" && \
  DEST="/usr/share/applications/duckstation-pa.desktop" && \
  echo '[Desktop Entry]' > "${DEST}" && \
  echo 'Type=Application' >> "${DEST}" && \
  echo 'Categories=Game;Emulator;' >> "${DEST}" && \
  echo 'Name=DuckStation PA' >> "${DEST}" && \
  echo 'GenericName=PlayStation 1 Emulator' >> "${DEST}" && \
  echo 'Comment=Fast PlayStation 1 emulator' >> "${DEST}" && \
  echo 'Icon=org.duckstation.DuckStation' >> "${DEST}" && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':duckstation %U"' >> "${DEST}" && \
  echo "**** set bin name ****" && \
  echo "duckstation-pa" > /bin-name && \
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
