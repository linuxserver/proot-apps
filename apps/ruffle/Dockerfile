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
    libfreetype6 \
    libgl1 \
    libgtk-3-0t64 \
    libssl3t64 \
    libudev1 \
    libvulkan1 \
    libwayland-client0 \
    libwayland-egl1 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcursor1 \
    libxi6 \
    libxkbcommon-x11-0 \
    libxkbcommon0 \
    libxrandr2 \
    mesa-vulkan-drivers && \
  RUFFLE_URL=$(curl -sX GET "https://api.github.com/repos/ruffle-rs/ruffle/releases/latest" \
    | jq -r '.assets[] | select(.name | test("linux-x86_64\\.tar\\.gz$")) | .browser_download_url') && \
  curl -o \
    /tmp/ruffle.tar.gz -L \
    "${RUFFLE_URL}" && \
  mkdir -p /opt/ruffle && \
  tar xf \
    /tmp/ruffle.tar.gz -C \
    /opt/ruffle && \
  chmod +x /opt/ruffle/ruffle && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:ruffle %u\"" \
    -e "s/^Name=Ruffle$/Name=Ruffle PA/g" \
    -e '/^TryExec=/d' \
    /opt/ruffle/extras/rs.ruffle.Ruffle.desktop && \
  mv \
    /opt/ruffle/extras/rs.ruffle.Ruffle.desktop \
    /usr/share/applications/ruffle-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "ruffle-pa" > /bin-name && \
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
