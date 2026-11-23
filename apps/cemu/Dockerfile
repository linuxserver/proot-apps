ARG REPO
FROM ghcr.io/${REPO}:ubuntu-resolute AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libopengl0 && \
  echo "**** install cemu ****" && \
  mkdir /tmp/cemu && \
  CEMU_JSON=$(curl -sX GET "https://api.github.com/repos/cemu-project/Cemu/releases/latest") && \
  CEMU_VERSION=$(printf "%s" "${CEMU_JSON}" | jq -er '.tag_name') && \
  CEMU_URL=$(printf "%s" "${CEMU_JSON}" \
    | jq -er '.assets[] | select(.name | endswith("-x86_64.AppImage")) | .browser_download_url') && \
  curl -o \
    /tmp/cemu/cemu.app -L \
    "${CEMU_URL}" && \
  cd /tmp/cemu && \
  chmod +x cemu.app && \
  ./cemu.app --appimage-extract && \
  mv \
    squashfs-root \
    /opt/cemu && \
  rm -f \
    /opt/cemu/usr/lib/libudev.so* && \
  mkdir -p /usr/share/icons/hicolor/scalable/apps && \
  cp \
    /opt/cemu/usr/share/icons/hicolor/128x128/apps/info.cemu.Cemu.png \
    /usr/share/icons/hicolor/scalable/apps/info.cemu.Cemu.png && \
  echo "**** create desktop file ****" && \
  DEST="/usr/share/applications/cemu-pa.desktop" && \
  echo '[Desktop Entry]' > "${DEST}" && \
  echo 'Version=1.0' >> "${DEST}" && \
  echo 'Name=Cemu PA' >> "${DEST}" && \
  echo 'GenericName=Wii U Emulator' >> "${DEST}" && \
  echo 'Comment=Software to emulate Wii U games and applications on PC' >> "${DEST}" && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':cemu %U"' >> "${DEST}" && \
  echo 'Icon=info.cemu.Cemu' >> "${DEST}" && \
  echo 'Terminal=false' >> "${DEST}" && \
  echo 'Type=Application' >> "${DEST}" && \
  echo 'Categories=Game;Emulator;' >> "${DEST}" && \
  echo 'MimeType=application/x-wii-u-rom;' >> "${DEST}" && \
  echo 'Keywords=Nintendo;' >> "${DEST}" && \
  echo "**** record upstream versions ****" && \
  echo "cemu ${CEMU_VERSION#v}" > /upstream-versions && \
  echo "**** set bin name ****" && \
  echo "cemu-pa" > /bin-name && \
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
