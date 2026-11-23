ARG REPO
FROM ghcr.io/${REPO}:ubuntu-resolute AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libopengl0 && \
  echo "**** install dolphin ****" && \
  mkdir /tmp/dolphin && \
  for DOLPHIN_TAG in $(curl -sX GET "https://api.github.com/repos/dolphin-emu/dolphin/tags?per_page=50" \
    | jq -er '[.[].name | select(test("^[0-9]{4}[a-z]?$"))] | sort | reverse | .[]'); do \
    if curl -sfIL -o /dev/null "https://dl.dolphin-emu.org/releases/${DOLPHIN_TAG}/dolphin-${DOLPHIN_TAG}-x64.AppImage"; then \
      DOLPHIN_VERSION="${DOLPHIN_TAG}"; \
      break; \
    fi; \
  done && \
  curl -fo \
    /tmp/dolphin/dolphin.app -L \
    "https://dl.dolphin-emu.org/releases/${DOLPHIN_VERSION}/dolphin-${DOLPHIN_VERSION}-x64.AppImage" && \
  cd /tmp/dolphin && \
  chmod +x dolphin.app && \
  ./dolphin.app --appimage-extract && \
  mv \
    squashfs-root \
    /opt/dolphin && \
  rm -f \
    /opt/dolphin/usr/lib/libudev.so* && \
  mkdir -p /usr/share/icons/hicolor/scalable/apps && \
  cp \
    /opt/dolphin/usr/share/icons/hicolor/scalable/apps/dolphin-emu.svg \
    /usr/share/icons/hicolor/scalable/apps/dolphin-emu.svg && \
  echo "**** create desktop file ****" && \
  DEST="/usr/share/applications/dolphin-pa.desktop" && \
  echo '[Desktop Entry]' > "${DEST}" && \
  echo 'Version=1.0' >> "${DEST}" && \
  echo 'Type=Application' >> "${DEST}" && \
  echo 'Terminal=false' >> "${DEST}" && \
  echo 'Name=Dolphin Emulator PA' >> "${DEST}" && \
  echo 'GenericName=Wii/GameCube Emulator' >> "${DEST}" && \
  echo 'Comment=A Wii/GameCube Emulator' >> "${DEST}" && \
  echo 'Icon=dolphin-emu' >> "${DEST}" && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':dolphin %U"' >> "${DEST}" && \
  echo 'Categories=Game;Emulator;' >> "${DEST}" && \
  echo "**** record upstream versions ****" && \
  echo "dolphin ${DOLPHIN_VERSION}" > /upstream-versions && \
  echo "**** set bin name ****" && \
  echo "dolphin-pa" > /bin-name && \
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
