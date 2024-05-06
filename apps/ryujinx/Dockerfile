ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libvulkan1 && \
  ARCH=$(uname -m| sed 's/x86_64/x64/g'| sed 's/aarch64/arm64/') && \
  RYU_VERSION=$(curl -sX GET "https://api.github.com/repos/Ryujinx/release-channel-master/releases/latest" \
    | awk '/tag_name/{print $4;exit}' FS='[""]') && \
  curl \
    -o /tmp/ryujinx.tar.gz -L \
    "https://github.com/Ryujinx/release-channel-master/releases/download/${RYU_VERSION}/ryujinx-${RYU_VERSION}-linux_${ARCH}.tar.gz" && \
  mkdir -p \
    /opt/ryujinx/ && \
  tar -xf \
    /tmp/ryujinx.tar.gz -C \
    /opt/ryujinx/ --strip-components=1 && \
  echo "**** customize desktop file ****" && \
  DEST="/usr/share/applications/ryujinx-pa.desktop" && \
  echo '[Desktop Entry]' > "${DEST}" && \
  echo 'Name=Ryujinx PA' >> "${DEST}" && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':ryujinx %U"' >> "${DEST}" && \
  echo 'Icon=ryujinx' >> "${DEST}" && \
  echo 'Type=Application' >> "${DEST}" && \
  echo 'Categories=Game;' >> "${DEST}" && \
  mkdir -p \
    /usr/share/icons/hicolor/scalable/apps/ && \
  curl -o \
    /usr/share/icons/hicolor/scalable/apps/ryujinx.svg -L \
    "https://upload.wikimedia.org/wikipedia/commons/f/fa/Ryujinx.svg" && \
  echo "**** set bin name ****" && \
  echo "ryujinx-pa" > /bin-name && \
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
