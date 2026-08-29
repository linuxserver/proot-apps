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
    libxkbcommon-x11-0 \
    unzip && \
  echo "**** install shadps4qt ****" && \
  mkdir /tmp/shadps4 && \
  SHADPS4_VERSION=$(curl -sX GET "https://api.github.com/repos/shadps4-emu/shadps4-qtlauncher/releases" \
    | jq -er '.[0].tag_name') && \
  SHORT_VERSION=$(echo "$SHADPS4_VERSION" | sed 's/shadPS4QtLauncher-//' | cut -c 1-18) && \
  curl -o \
    /tmp/shadps4/shad.zip -L \
    "https://github.com/shadps4-emu/shadps4-qtlauncher/releases/download/${SHADPS4_VERSION}/shadPS4QtLauncher-linux-qt-${SHORT_VERSION}.zip" && \
  cd /tmp/shadps4 && \
  unzip shad.zip && \
  chmod +x shadPS4QtLauncher-qt.AppImage && \
  ./shadPS4QtLauncher-qt.AppImage --appimage-extract && \
  mv \
    squashfs-root \
    /opt/shadps4 && \
  mkdir -p /usr/share/icons/hicolor/scalable/apps && \
  cp \
    /opt/shadps4/net.shadps4.shadPS4.svg \
    /usr/share/icons/hicolor/scalable/apps/net.shadps4.shadPS4.svg && \
  echo "**** install pkg extractor ****" && \
  PKG_URL=$(curl -sX GET "https://api.github.com/repos/AzaharPlus/shadPS4Plus/releases/latest" \
    | jq -er '.assets[] | select(.name | endswith("-linux.zip")) | .browser_download_url') && \
  curl -o \
    /tmp/pkg.zip -L \
    "${PKG_URL}" && \
  cd /tmp && \
  unzip pkg.zip && \
  cd ShadPs4Plus-PkgExtractor* && \
  chmod +x pkg_extractor.AppImage && \
  ./pkg_extractor.AppImage --appimage-extract && \
  mv \
    squashfs-root/usr/bin/pkg_extractor \
    /usr/local/bin/ && \
  echo "**** create desktop file ****" && \
  DEST="/usr/share/applications/shadps4-pa.desktop" && \
  echo '[Desktop Entry]' > "${DEST}" && \
  echo 'Name=shadPS4 Qt Launcher PA' >> "${DEST}" && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':shadps4 %U"' >> "${DEST}" && \
  echo 'Terminal=false' >> "${DEST}" && \
  echo 'Type=Application' >> "${DEST}" && \
  echo 'Icon=net.shadps4.shadPS4' >> "${DEST}" && \
  echo 'Comment=Launcher for shadPS4 emulator' >> "${DEST}" && \
  echo 'Categories=Game;Emulator;' >> "${DEST}" && \
  echo 'StartupWMClass=shadPS4QtLauncher;' >> "${DEST}" && \
  echo "**** set bin name ****" && \
  echo "shadps4-pa" > /bin-name && \
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
