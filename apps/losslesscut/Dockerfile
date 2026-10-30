ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS rootfs
ARG REPO

# Add local files
COPY /root /

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libasound2t64 \
    libatk1.0-0t64 \
    libatk-bridge2.0-0t64 \
    libcups2 \
    libdrm2 \
    libgbm1 \
    libgtk-3-0t64 \
    libnss3 \
    libxcomposite1 \
    libxdamage1 \
    libxkbcommon0 \
    libxrandr2 && \
  LOSSLESSCUT_VERSION=$(curl -sX GET "https://api.github.com/repos/mifi/lossless-cut/releases/latest" \
    | jq -r '.tag_name') && \
  URL="https://github.com/mifi/lossless-cut/releases/download/${LOSSLESSCUT_VERSION}/LosslessCut-linux-x86_64.AppImage" && \
  curl -o \
    /tmp/losslesscut.app -L \
    "${URL}" && \
  chmod +x /tmp/losslesscut.app && \
  cd /tmp && \
  ./losslesscut.app --appimage-extract && \
  mv squashfs-root /opt/losslesscut && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:losslesscut %U\"" \
    -e "s/^Name=LosslessCut$/Name=LosslessCut PA/g" \
    -e '/^X-AppImage-Version=/d' \
    -e '/^TryExec=/d' \
    /opt/losslesscut/losslesscut.desktop && \
  mv \
    /opt/losslesscut/losslesscut.desktop \
    /usr/share/applications/losslesscut-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "losslesscut-pa" > /bin-name && \
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
