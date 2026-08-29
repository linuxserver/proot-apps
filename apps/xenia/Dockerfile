ARG REPO
FROM ghcr.io/${REPO}:ubuntu-resolute AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libgl1 \
    libgtk-3-0t64 \
    libpulse0 && \
  echo "**** install xenia-edge ****" && \
  XENIA_VERSION=$(curl -sX GET "https://api.github.com/repos/has207/xenia-edge/releases/latest" \
    | jq -er '.tag_name') && \
  curl -o \
    /tmp/xenia.app -L \
    "https://github.com/has207/xenia-edge/releases/download/${XENIA_VERSION}/xenia_edge_linux.AppImage" && \
  cd /tmp && \
  chmod +x xenia.app && \
  ./xenia.app --appimage-extract && \
  mv \
    squashfs-root \
    /opt/xenia && \
  mkdir -p /usr/share/icons/hicolor/scalable/apps && \
  cp \
    /opt/xenia/usr/share/icons/hicolor/128x128/apps/xenia_edge.png \
    /usr/share/icons/hicolor/scalable/apps/xenia_edge.png && \
  echo "**** create desktop file ****" && \
  DEST="/usr/share/applications/xenia-pa.desktop" && \
  echo '[Desktop Entry]' > "${DEST}" && \
  echo 'Type=Application' >> "${DEST}" && \
  echo 'Name=Xenia Edge PA' >> "${DEST}" && \
  echo 'GenericName=Xbox 360 Emulator' >> "${DEST}" && \
  echo 'Comment=Xbox 360 Research Emulator' >> "${DEST}" && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':xenia %U"' >> "${DEST}" && \
  echo 'Icon=xenia_edge' >> "${DEST}" && \
  echo 'Terminal=false' >> "${DEST}" && \
  echo 'Categories=Game;Emulator;' >> "${DEST}" && \
  echo 'MimeType=application/x-xbox360-executable;application/x-xbox360-iso;' >> "${DEST}" && \
  echo 'StartupWMClass=xenia_edge' >> "${DEST}" && \
  echo "**** set bin name ****" && \
  echo "xenia-pa" > /bin-name && \
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
