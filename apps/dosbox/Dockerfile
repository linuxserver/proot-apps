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
    xz-utils && \
  echo "**** install dosbox ****" && \
  DSTAGING_VERSION=$(curl -sX GET "https://api.github.com/repos/dosbox-staging/dosbox-staging/releases/latest" \
    | jq -er '.tag_name') && \
  curl -o \
    /tmp/dosbox.tar.xz -L \
    "https://github.com/dosbox-staging/dosbox-staging/releases/download/${DSTAGING_VERSION}/dosbox-staging-linux-x86_64-${DSTAGING_VERSION}.tar.xz" && \
  mkdir /opt/dosbox && \
  tar xf \
    /tmp/dosbox.tar.xz -C \
    /opt/dosbox --strip-components=1 && \
  mkdir -p /usr/share/icons/hicolor/scalable/apps && \
  cp \
    /opt/dosbox/icons/hicolor/scalable/apps/org.dosbox_staging.dosbox_staging.svg \
    /usr/share/icons/hicolor/scalable/apps/org.dosbox_staging.dosbox_staging.svg && \
  echo "**** create desktop file ****" && \
  DEST="/usr/share/applications/dosbox-pa.desktop" && \
  echo '[Desktop Entry]' > "${DEST}" && \
  echo 'Name=DOSBox Staging PA' >> "${DEST}" && \
  echo 'GenericName=DOS emulator' >> "${DEST}" && \
  echo 'Comment=DOS/x86 emulator focusing on ease of use' >> "${DEST}" && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':dosbox %U"' >> "${DEST}" && \
  echo 'Icon=org.dosbox_staging.dosbox_staging' >> "${DEST}" && \
  echo 'Type=Application' >> "${DEST}" && \
  echo 'Terminal=false' >> "${DEST}" && \
  echo 'Keywords=dos;gaming;game;games;emulator;' >> "${DEST}" && \
  echo 'Categories=Game;Emulator;' >> "${DEST}" && \
  echo "**** set bin name ****" && \
  echo "dosbox-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  apt-get remove -y xz-utils && \
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
