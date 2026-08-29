ARG REPO
FROM ghcr.io/${REPO}:ubuntu-resolute AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libgl1 \
    libglu1-mesa \
    libpulse0 \
    libxcb-cursor0 \
    libxkbcommon-x11-0 && \
  echo "**** install azahar ****" && \
  AZAHAR_URL=$(curl -sX GET "https://api.github.com/repos/azahar-emu/azahar/releases/latest" \
    | jq -er '.assets[] | select(.name == "azahar-wayland.AppImage") | .browser_download_url') && \
  curl -o \
    /tmp/azahar.app -L \
    "${AZAHAR_URL}" && \
  cd /tmp && \
  chmod +x azahar.app && \
  ./azahar.app --appimage-extract && \
  mv \
    squashfs-root \
    /opt/azahar && \
  mkdir -p /usr/share/icons/hicolor/scalable/apps && \
  cp \
    /opt/azahar/org.azahar_emu.Azahar.svg \
    /usr/share/icons/hicolor/scalable/apps/org.azahar_emu.Azahar.svg && \
  echo "**** create desktop file ****" && \
  DEST="/usr/share/applications/azahar-pa.desktop" && \
  echo '[Desktop Entry]' > "${DEST}" && \
  echo 'Version=1.0' >> "${DEST}" && \
  echo 'Type=Application' >> "${DEST}" && \
  echo 'Name=Azahar PA' >> "${DEST}" && \
  echo 'GenericName=3DS Emulator' >> "${DEST}" && \
  echo 'Comment=Nintendo 3DS video game console emulator' >> "${DEST}" && \
  echo 'Icon=org.azahar_emu.Azahar' >> "${DEST}" && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':azahar %U"' >> "${DEST}" && \
  echo 'Categories=Game;Emulator;' >> "${DEST}" && \
  echo 'MimeType=application/x-ctr-3dsx;application/x-ctr-cci;application/x-ctr-cia;application/x-ctr-cxi;' >> "${DEST}" && \
  echo 'Keywords=3DS;Nintendo;' >> "${DEST}" && \
  echo "**** set bin name ****" && \
  echo "azahar-pa" > /bin-name && \
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
