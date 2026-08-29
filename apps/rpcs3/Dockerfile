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
    libxkbcommon-x11-0 && \
  echo "**** install rpcs3 ****" && \
  RPCS3_URL=$(curl -sX GET "https://api.github.com/repos/RPCS3/rpcs3-binaries-linux/releases/latest" \
    | jq -er '.assets[] | select(.name | endswith("_linux64.AppImage")) | .browser_download_url') && \
  curl -o \
    /tmp/rpcs3.app -L \
    "${RPCS3_URL}" && \
  cd /tmp && \
  chmod +x rpcs3.app && \
  ./rpcs3.app --appimage-extract && \
  mv \
    AppDir \
    /opt/rpcs3 && \
  mkdir -p /usr/share/icons/hicolor/scalable/apps && \
  cp \
    /opt/rpcs3/usr/share/icons/hicolor/scalable/apps/rpcs3.svg \
    /usr/share/icons/hicolor/scalable/apps/rpcs3.svg && \
  echo "**** create desktop file ****" && \
  DEST="/usr/share/applications/rpcs3-pa.desktop" && \
  echo '[Desktop Entry]' > "${DEST}" && \
  echo 'Type=Application' >> "${DEST}" && \
  echo 'Name=RPCS3 PA' >> "${DEST}" && \
  echo 'GenericName=PlayStation 3 Emulator' >> "${DEST}" && \
  echo 'Icon=rpcs3' >> "${DEST}" && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':rpcs3 %U"' >> "${DEST}" && \
  echo 'Terminal=false' >> "${DEST}" && \
  echo 'Categories=Game;Emulator;' >> "${DEST}" && \
  echo "**** set bin name ****" && \
  echo "rpcs3-pa" > /bin-name && \
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
