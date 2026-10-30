ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    git \
    libasound2t64 \
    libatk1.0-0t64 \
    libatk-bridge2.0-0t64 \
    libcups2 \
    libdrm2 \
    libgbm1 \
    libgtk-3-0t64 \
    libnss3 \
    libsecret-1-0 \
    libxcomposite1 \
    libxdamage1 \
    libxkbcommon0 \
    libxkbfile1 \
    libxrandr2 \
    openssh-client && \
  URL=$(curl -sL -A "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0 Safari/537.36" \
    "https://www.cursor.com/api/download?platform=linux-x64&releaseTrack=stable" \
    | jq -r '.downloadUrl') && \
  curl -o \
    /tmp/cursor.app -L \
    "${URL}" && \
  chmod +x /tmp/cursor.app && \
  cd /tmp && \
  ./cursor.app --appimage-extract && \
  mv squashfs-root /opt/cursor && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e '/^\[Desktop Action/,$d' \
    -e '/^Actions=/d' \
    -e '/^X-AppImage-Version=/d' \
    -e '/^$/d' \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:cursor %F\"" \
    -e "s/^Name=Cursor$/Name=Cursor PA/g" \
    -e 's/^Icon=co.anysphere.cursor$/Icon=cursor/g' \
    -e '/^TryExec=/d' \
    /opt/cursor/cursor.desktop && \
  mv \
    /opt/cursor/cursor.desktop \
    /usr/share/applications/cursor-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "cursor-pa" > /bin-name && \
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
