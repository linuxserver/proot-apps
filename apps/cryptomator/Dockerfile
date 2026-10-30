ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libasound2t64 \
    libayatana-appindicator3-1 \
    libfontconfig1 \
    libfreetype6 \
    libfuse3-4 \
    libgl1 \
    libgtk-3-0t64 \
    libx11-6 \
    libxext6 \
    libxi6 \
    libxrender1 \
    libxtst6 && \
  CRYPTOMATOR_VERSION=$(curl -sX GET "https://api.github.com/repos/cryptomator/cryptomator/releases/latest" \
    | jq -r '.tag_name') && \
  curl -o \
    /tmp/cryptomator.app -L \
    "https://github.com/cryptomator/cryptomator/releases/download/${CRYPTOMATOR_VERSION}/cryptomator-${CRYPTOMATOR_VERSION}-x86_64.AppImage" && \
  chmod +x /tmp/cryptomator.app && \
  cd /tmp && \
  ./cryptomator.app --appimage-extract && \
  mv squashfs-root /opt/cryptomator && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:cryptomator %F\"" \
    -e "s/^Name=Cryptomator$/Name=Cryptomator PA/g" \
    -e '/^TryExec=/d' \
    -e '/^X-AppImage-Version=/d' \
    /opt/cryptomator/org.cryptomator.Cryptomator.desktop && \
  mv \
    /opt/cryptomator/org.cryptomator.Cryptomator.desktop \
    /usr/share/applications/cryptomator-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "cryptomator-pa" > /bin-name && \
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
