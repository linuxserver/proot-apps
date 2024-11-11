ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y \
    ffmpeg \
    lame \
    libatk1.0 \
    libatk-bridge2.0 \
    libnss3 \
    libportaudio2 \
    python3-xdg && \
  AUDACITY_VERSION=$(curl -sX GET "https://api.github.com/repos/audacity/audacity/releases/latest" \
    | awk '/tag_name/{print $4;exit}' FS='[""]' | sed 's|^Audacity-||') && \
  cd /tmp && \
  curl -o \
    /tmp/audacity.app -L \
    "https://github.com/audacity/audacity/releases/download/Audacity-${AUDACITY_VERSION}/audacity-linux-${AUDACITY_VERSION}-x64-22.04.AppImage" && \
  chmod +x /tmp/audacity.app && \
  ./audacity.app --appimage-extract && \
  mv squashfs-root /opt/audacity && \
  ln -s \
    /usr/lib/x86_64-linux-gnu/libportaudio.so.2 \
    /usr/lib/x86_64-linux-gnu/libportaudio.so && \
  rm -f \
    /opt/audacity/share/audacity/plug-ins/eq-xml-to-txt-converter.ny \
    /opt/audacity/share/audacity/plug-ins/rms.ny && \
  echo "**** customize desktop file ****" && \
  DFILE=/opt/audacity/audacity.desktop && \
  DEST=/usr/share/applications/audacity-pa.desktop && \
  DKEEP=$(cat "${DFILE}" |sed '/^\(\Icon=\|Terminal=\|MimeType=\|Categories=\|Type=\|StartupNotify=\)/!d' |awk '!a[$0]++') && \
  echo '[Desktop Entry]' > "${DEST}" && \
  echo 'Name=Audacity PA' >> "${DEST}" && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':audacity %U"' >> "${DEST}" && \
  echo "${DKEEP}" >> "${DEST}" && \
  echo "audacity-pa" > /bin-name && \
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
