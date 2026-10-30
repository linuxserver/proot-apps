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
    libsecret-1-0 \
    libxcomposite1 \
    libxdamage1 \
    libxkbcommon0 \
    libxrandr2 && \
  LOGSEQ_VERSION=$(curl -sX GET "https://api.github.com/repos/logseq/logseq/releases/latest" \
    | jq -r '.tag_name') && \
  URL="https://github.com/logseq/logseq/releases/download/${LOGSEQ_VERSION}/Logseq-linux-x86_64-${LOGSEQ_VERSION}.AppImage" && \
  curl -o \
    /tmp/logseq.app -L \
    "${URL}" && \
  chmod +x /tmp/logseq.app && \
  cd /tmp && \
  ./logseq.app --appimage-extract && \
  mv squashfs-root /opt/logseq && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:logseq %U\"" \
    -e "s/^Name=Logseq$/Name=Logseq PA/g" \
    -e '/^X-AppImage-Version=/d' \
    -e '/^TryExec=/d' \
    /opt/logseq/logseq.desktop && \
  mv \
    /opt/logseq/logseq.desktop \
    /usr/share/applications/logseq-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "logseq-pa" > /bin-name && \
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
