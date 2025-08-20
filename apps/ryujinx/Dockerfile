ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y \
     libicu76 && \
  ARCH=$(uname -m| sed 's/x86_64/x64/g'| sed 's/aarch64/arm64/') && \
  RYU_DL=$(curl -i -s "https://update.ryujinx.app/download/query?os=linux&arch=${ARCH}&rc=stable" \
    | awk '/location:/ {print $2}' | tr -d '\r') && \
  curl \
    -o /tmp/ryujinx.tar.gz -L \
    "${RYU_DL}" && \
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
