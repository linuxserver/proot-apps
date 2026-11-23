ARG REPO
FROM ghcr.io/${REPO}:ubuntu-resolute AS rootfs
ARG REPO

# Install eden
RUN \
  echo "**** install eden ****" && \
  mkdir /tmp/eden && \
  EDEN_JSON=$(curl -sX GET "https://git.eden-emu.dev/api/v1/repos/eden-emu/eden/releases/latest") && \
  EDEN_VERSION=$(printf "%s" "${EDEN_JSON}" | jq -er '.tag_name') && \
  EDEN_URL=$(printf "%s" "${EDEN_JSON}" \
    | jq -er '.assets[] | select(.name | test("^Eden-Linux-.*-amd64-clang-pgo\\.AppImage$")) | .browser_download_url') && \
  curl -o \
    /tmp/eden/eden.app -L \
    "${EDEN_URL}" && \
  cd /tmp/eden && \
  chmod +x eden.app && \
  ./eden.app --appimage-extract && \
  mv \
    AppDir \
    /opt/eden && \
  rm -f \
    /opt/eden/shared/lib/libudev.so* && \
  mkdir -p /usr/share/icons/hicolor/scalable/apps && \
  cp \
    /opt/eden/dev.eden_emu.eden.svg \
    /usr/share/icons/hicolor/scalable/apps/dev.eden_emu.eden.svg && \
  echo "**** create desktop file ****" && \
  DEST="/usr/share/applications/eden-pa.desktop" && \
  echo '[Desktop Entry]' > "${DEST}" && \
  echo 'Version=1.0' >> "${DEST}" && \
  echo 'Type=Application' >> "${DEST}" && \
  echo 'Name=Eden PA' >> "${DEST}" && \
  echo 'GenericName=Switch Emulator' >> "${DEST}" && \
  echo 'Comment=Multiplatform FOSS Switch 1 emulator written in C++, derived from Yuzu and Sudachi' >> "${DEST}" && \
  echo 'Icon=dev.eden_emu.eden' >> "${DEST}" && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':eden %U"' >> "${DEST}" && \
  echo 'Categories=Game;Emulator;Qt;' >> "${DEST}" && \
  echo 'MimeType=application/x-nx-nro;application/x-nx-nso;application/x-nx-nsp;application/x-nx-xci;' >> "${DEST}" && \
  echo 'Keywords=Nintendo;Switch;' >> "${DEST}" && \
  echo 'StartupWMClass=eden' >> "${DEST}" && \
  echo "**** record upstream versions ****" && \
  echo "eden ${EDEN_VERSION#v}" > /upstream-versions && \
  echo "**** set bin name ****" && \
  echo "eden-pa" > /bin-name && \
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
