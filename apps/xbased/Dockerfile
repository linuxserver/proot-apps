ARG REPO
FROM ghcr.io/${REPO}:ubuntu-resolute AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libasound2t64 \
    libegl1 \
    libgl1 \
    libpulse0 \
    libwayland-cursor0 \
    libwayland-egl1 \
    libxcursor1 \
    libxi6 \
    libxkbcommon0 \
    libxrandr2 \
    libxss1 \
    zenity && \
  echo "**** install xbased ****" && \
  XBASED_VERSION=$(curl -sX GET "https://api.github.com/repos/crazyriddler/xbased/releases/latest" \
    | jq -er '.tag_name') && \
  XBASED_URL=$(curl -sX GET "https://api.github.com/repos/crazyriddler/xbased/releases/latest" \
    | jq -er '.assets[] | select(.name | endswith("-x86_64.AppImage")) | .browser_download_url') && \
  curl -o \
    /tmp/xbased.app -L \
    "${XBASED_URL}" && \
  cd /tmp && \
  chmod +x xbased.app && \
  ./xbased.app --appimage-extract && \
  mv \
    squashfs-root \
    /opt/xbased && \
  mkdir -p /usr/share/icons/hicolor/scalable/apps && \
  cp \
    /opt/xbased/usr/share/icons/hicolor/256x256/apps/xbased.png \
    /usr/share/icons/hicolor/scalable/apps/xbased.png && \
  echo "**** create desktop file ****" && \
  DEST="/usr/share/applications/xbased-pa.desktop" && \
  echo '[Desktop Entry]' > "${DEST}" && \
  echo 'Version=1.0' >> "${DEST}" && \
  echo 'Type=Application' >> "${DEST}" && \
  echo 'Terminal=false' >> "${DEST}" && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':xbased %f"' >> "${DEST}" && \
  echo 'Name=xbased PA' >> "${DEST}" && \
  echo 'GenericName=Xbox Emulator' >> "${DEST}" && \
  echo 'Comment=Emulator for the original Xbox console' >> "${DEST}" && \
  echo 'Icon=xbased' >> "${DEST}" && \
  echo 'Categories=Game;Emulator;' >> "${DEST}" && \
  echo 'Keywords=original;xbox;game;console;emulator;xbased;' >> "${DEST}" && \
  echo "**** record upstream versions ****" && \
  echo "xbased ${XBASED_VERSION#v}" > /upstream-versions && \
  echo "**** set bin name ****" && \
  echo "xbased-pa" > /bin-name && \
  echo "**** run without the ptrace tier ****" && \
  touch /no-ptrace && \
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
