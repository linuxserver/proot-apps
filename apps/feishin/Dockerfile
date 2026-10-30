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
    libayatana-appindicator3-1 \
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
    libxrandr2 \
    mpv && \
  FEISHIN_VERSION=$(curl -sX GET "https://api.github.com/repos/jeffvli/feishin/releases/latest" \
    | jq -r '.tag_name') && \
  URL="https://github.com/jeffvli/feishin/releases/download/${FEISHIN_VERSION}/Feishin-linux-x86_64.AppImage" && \
  curl -o \
    /tmp/feishin.app -L \
    "${URL}" && \
  chmod +x /tmp/feishin.app && \
  cd /tmp && \
  ./feishin.app --appimage-extract && \
  mv squashfs-root /opt/feishin && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:feishin %U\"" \
    -e "s/^Name=Feishin$/Name=Feishin PA/g" \
    -e '/^X-AppImage-Version=/d' \
    -e '/^TryExec=/d' \
    /opt/feishin/feishin.desktop && \
  mv \
    /opt/feishin/feishin.desktop \
    /usr/share/applications/feishin-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "feishin-pa" > /bin-name && \
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
