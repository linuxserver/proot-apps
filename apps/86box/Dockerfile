ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS rootfs
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
  echo "**** install 86box ****" && \
  BOX_URL=$(curl -sX GET "https://api.github.com/repos/86Box/86Box/releases/latest" \
    | jq -er '.assets[] | select(.name | test("86Box-Linux-x86_64-b[0-9]+\\.AppImage$")) | .browser_download_url') && \
  curl -o \
    /tmp/86box.app -L \
    "${BOX_URL}" && \
  cd /tmp && \
  chmod +x 86box.app && \
  ./86box.app --appimage-extract && \
  mv \
    squashfs-root \
    /opt/86box && \
  mkdir -p /usr/share/icons/hicolor/scalable/apps && \
  cp \
    /opt/86box/usr/share/icons/hicolor/256x256/apps/net.86box.86Box.png \
    /usr/share/icons/hicolor/scalable/apps/net.86box.86Box.png && \
  echo "**** install roms ****" && \
  ROMS_URL=$(curl -sX GET "https://api.github.com/repos/86Box/roms/releases/latest" \
    | jq -er '.tarball_url') && \
  curl -o \
    /tmp/roms.tar.gz -L \
    "${ROMS_URL}" && \
  mkdir -p /opt/86box/usr/local/share/86Box/roms && \
  tar xf \
    /tmp/roms.tar.gz -C \
    /opt/86box/usr/local/share/86Box/roms --strip-components=1 && \
  rm -rf /opt/86box/usr/local/share/86Box/roms/.github && \
  echo "**** create desktop file ****" && \
  DEST="/usr/share/applications/86box-pa.desktop" && \
  echo '[Desktop Entry]' > "${DEST}" && \
  echo 'Type=Application' >> "${DEST}" && \
  echo 'Categories=Game;Emulator;' >> "${DEST}" && \
  echo 'Name=86Box PA' >> "${DEST}" && \
  echo 'GenericName=Classic PC emulator' >> "${DEST}" && \
  echo 'Comment=An emulator for classic IBM PC clones' >> "${DEST}" && \
  echo 'Icon=net.86box.86Box' >> "${DEST}" && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':86box"' >> "${DEST}" && \
  echo 'Terminal=false' >> "${DEST}" && \
  echo "**** set bin name ****" && \
  echo "86box-pa" > /bin-name && \
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
