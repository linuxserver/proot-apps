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
  echo "**** install vita3k ****" && \
  curl -o \
    /tmp/vita3k.app -L \
    "https://github.com/Vita3K/Vita3K/releases/download/continuous/Vita3K-x86_64.AppImage" && \
  cd /tmp && \
  chmod +x vita3k.app && \
  ./vita3k.app --appimage-extract && \
  mv \
    "$(readlink -f squashfs-root)" \
    /opt/vita3k && \
  mkdir -p /usr/share/icons/hicolor/scalable/apps && \
  cp \
    /opt/vita3k/org.vita3k.vita3k.svg \
    /usr/share/icons/hicolor/scalable/apps/org.vita3k.vita3k.svg && \
  echo "**** create desktop file ****" && \
  DEST="/usr/share/applications/vita3k-pa.desktop" && \
  echo '[Desktop Entry]' > "${DEST}" && \
  echo 'Type=Application' >> "${DEST}" && \
  echo 'Categories=Game;Emulator;' >> "${DEST}" && \
  echo 'Name=Vita3K PA' >> "${DEST}" && \
  echo 'GenericName=PlayStation Vita Emulator' >> "${DEST}" && \
  echo 'Comment=Experimental Playstation Vita emulator' >> "${DEST}" && \
  echo 'Icon=org.vita3k.vita3k' >> "${DEST}" && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':vita3k"' >> "${DEST}" && \
  echo 'StartupWMClass=Vita3K' >> "${DEST}" && \
  echo "**** set bin name ****" && \
  echo "vita3k-pa" > /bin-name && \
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
