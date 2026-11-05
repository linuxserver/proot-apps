ARG REPO
FROM ghcr.io/${REPO}:ubuntu-resolute AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libgles2 \
    libopengl0 \
    libusb-1.0-0 && \
  echo "**** install lichii ****" && \
  mkdir /tmp/lichii && \
  LICHII_URL=$(curl -sX GET "https://api.github.com/repos/zortos293/Lichii/releases" \
    | jq -er 'first(.[].assets[] | select(.name == "lichii-linux-x86_64-pgo.AppImage") | .browser_download_url)') && \
  curl -o \
    /tmp/lichii/lichii.app -L \
    "${LICHII_URL}" && \
  cd /tmp/lichii && \
  chmod +x lichii.app && \
  ./lichii.app --appimage-extract && \
  mv \
    squashfs-root \
    /opt/lichii && \
  mkdir -p /usr/share/icons/hicolor/scalable/apps && \
  cp \
    /opt/lichii/usr/share/icons/hicolor/256x256/apps/io.github.zortos293.lichii.png \
    /usr/share/icons/hicolor/scalable/apps/io.github.zortos293.lichii.png && \
  echo "**** create desktop file ****" && \
  DEST="/usr/share/applications/lichii-pa.desktop" && \
  echo '[Desktop Entry]' > "${DEST}" && \
  echo 'Type=Application' >> "${DEST}" && \
  echo 'Categories=Game;Emulator;' >> "${DEST}" && \
  echo 'Name=Lichii PA' >> "${DEST}" && \
  echo 'GenericName=Switch Emulator' >> "${DEST}" && \
  echo 'Comment=Experimental Nintendo Switch and Switch 2 emulator' >> "${DEST}" && \
  echo 'Icon=io.github.zortos293.lichii' >> "${DEST}" && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':lichii %U"' >> "${DEST}" && \
  echo "**** set bin name ****" && \
  echo "lichii-pa" > /bin-name && \
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
