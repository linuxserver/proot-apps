ARG REPO
FROM ghcr.io/${REPO}:ubuntu-noble AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    git \
    gstreamer1.0-alsa \
    gstreamer1.0-gl \
    gstreamer1.0-gtk3 \
    gstreamer1.0-libav \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-pulseaudio \
    gstreamer1.0-qt5 \
    gstreamer1.0-tools \
    gstreamer1.0-x \
    libatk1.0 \
    libatk-bridge2.0 \
    libgstreamer-plugins-bad1.0 \
    libgtk-3-bin \
    libmspack0 \
    libnss3 \
    libwebkit2gtk-4.1-0 \
    libwx-perl \
    python3-xdg && \
  ORCASLICER_VERSION=$(curl -sX GET "https://api.github.com/repos/OrcaSlicer/OrcaSlicer/releases/latest" \
    | awk '/tag_name/{print $4;exit}' FS='[""]') && \
  RELEASE_URL=$(curl -sX GET "https://api.github.com/repos/OrcaSlicer/OrcaSlicer/releases/latest"     | awk '/url/{print $4;exit}' FS='[""]') && \
  DOWNLOAD_URL=$(curl -sX GET "${RELEASE_URL}" | awk '/browser_download_url.*Ubuntu2404/{print $4;exit}' FS='[""]') && \
  curl -o \
    /tmp/orcaslicer.app -L \
    "${DOWNLOAD_URL}" && \
  chmod +x /tmp/orcaslicer.app && \
  cd /tmp && \
  ./orcaslicer.app --appimage-extract && \
  mv squashfs-root /opt/orcaslicer && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:orcaslicer %U\"" \
    -e "s/Name=OrcaSlicer/Name=OrcaSlicer PA/g" \
    -e '/^TryExec=/d' \
    /opt/orcaslicer/OrcaSlicer.desktop && \
  mv \
    /opt/orcaslicer/OrcaSlicer.desktop \
    /usr/share/applications/orcaslicer-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "orcaslicer-pa" > /bin-name && \
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
