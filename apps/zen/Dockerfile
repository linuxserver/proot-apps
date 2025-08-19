ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y \
    libxkbcommon-x11-0 \
    libxdamage1 \
    libxcomposite1 \
    libnss3 \
    libgtk-3-0 \
    libcups2 \
    libatspi2.0-0 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    xz-utils && \
  ZEN_VERSION=$(curl -sX GET "https://api.github.com/repos/zen-browser/desktop/releases/latest" \
    | awk '/tag_name/{print $4;exit}' FS='[""]') && \
  curl -o \
    /tmp/zen.tar.xz -L \
    "https://github.com/zen-browser/desktop/releases/download/${ZEN_VERSION}/zen.linux-$(uname -m).tar.xz" && \
  mkdir -p /opt/zen && \
  tar xf \
    /tmp/zen.tar.xz -C \
    /opt/zen/ --strip-components=1 && \
  echo "**** customize desktop file ****" && \
  DESKTOP_FILE=/usr/share/applications/zen-pa.desktop && \
  echo '[Desktop Entry]' > ${DESKTOP_FILE} && \
  echo 'Type=Application' >> ${DESKTOP_FILE} && \
  echo 'Name=Zen PA' >> ${DESKTOP_FILE} && \
  echo 'Icon=zen' >> ${DESKTOP_FILE} && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':zen %U"' >> ${DESKTOP_FILE} && \
  echo "**** set bin name ****" && \
  echo "zen-pa" > /bin-name && \
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
