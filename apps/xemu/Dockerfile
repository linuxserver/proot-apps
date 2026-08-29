ARG REPO
FROM ghcr.io/${REPO}:ubuntu-resolute AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libgl1 \
    libpulse0 \
    libusb-1.0-0 && \
  echo "**** install xemu ****" && \
  mkdir /tmp/xemu && \
  XEMU_URL=$(curl -sX GET "https://api.github.com/repos/xemu-project/xemu/releases" \
    | jq -er 'first(.[].assets[] | select(.name | endswith("-x86_64.AppImage") and (contains("dbg") | not)) | .browser_download_url)') && \
  curl -o \
    /tmp/xemu/xemu.app -L \
    "${XEMU_URL}" && \
  cd /tmp/xemu && \
  chmod +x xemu.app && \
  ./xemu.app --appimage-extract && \
  mv \
    squashfs-root \
    /opt/xemu && \
  mkdir -p /usr/share/icons/hicolor/scalable/apps && \
  cp \
    /opt/xemu/xemu.svg \
    /usr/share/icons/hicolor/scalable/apps/xemu.svg && \
  echo "**** create desktop file ****" && \
  DEST="/usr/share/applications/xemu-pa.desktop" && \
  echo '[Desktop Entry]' > "${DEST}" && \
  echo 'Version=1.0' >> "${DEST}" && \
  echo 'Type=Application' >> "${DEST}" && \
  echo 'Terminal=false' >> "${DEST}" && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':xemu %U"' >> "${DEST}" && \
  echo 'Name=xemu PA' >> "${DEST}" && \
  echo 'Comment=Emulator for the original Xbox console' >> "${DEST}" && \
  echo 'Icon=xemu' >> "${DEST}" && \
  echo 'Categories=Game;Emulator;' >> "${DEST}" && \
  echo 'Keywords=original;xbox;game;console;emulator;xemu;' >> "${DEST}" && \
  echo "**** set bin name ****" && \
  echo "xemu-pa" > /bin-name && \
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
