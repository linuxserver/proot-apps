ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y \
    hicolor-icon-theme \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libnss3 \
    libxcomposite1 \
    libxdamage1 \
    libxkbcommon0 \
    xz-utils && \
  curl -o \
    /usr/share/icons/hicolor/scalable/apps/ungoogledchromium.svg -L \
    "https://github.com/linuxserver/proot-apps/raw/master/metadata/img/ungoogledchromium.svg" && \
  UGC_VERSION=$(curl -sX GET "https://api.github.com/repos/ungoogled-software/ungoogled-chromium-portablelinux/releases/latest" \
    | awk '/tag_name/{print $4;exit}' FS='[""]' | sed 's|^Audacity-||') && \
  cd /tmp && \
  curl -o \
    /tmp/ugc.tar.xz -L \
    "https://github.com/ungoogled-software/ungoogled-chromium-portablelinux/releases/download/${UGC_VERSION}/ungoogled-chromium_${UGC_VERSION}_linux.tar.xz" && \
  mkdir -p \
    /opt/ungoogledchromium && \
  tar xf \
    /tmp/ugc.tar.xz -C \
    /opt/ungoogledchromium --strip-components=1 && \
  echo "**** customize desktop file ****" && \
  DEST=/usr/share/applications/ungoogledchromium-pa.desktop && \
  echo '[Desktop Entry]' > "${DEST}" && \
  echo 'Name=Ungoogled Chromium PA' >> "${DEST}" && \
  echo 'Icon=ungoogledchromium' >> "${DEST}" && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':ungoogledchromium %U"' >> "${DEST}" && \
  echo 'StartupNotify=true' >> "${DEST}" && \
  echo 'Terminal=false' >> "${DEST}" && \
  echo 'Type=Application' >> "${DEST}" && \
  echo 'Categories=Network;WebBrowser;' >> "${DEST}" && \
  echo 'MimeType=application/pdf;application/rdf+xml;application/rss+xml;application/xhtml+xml;application/xhtml_xml;application/xml;image/gif;image/jpeg;image/png;image/webp;text/html;text/xml;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ipfs;x-scheme-handler/ipns;' >> "${DEST}" && \
  echo "ungoogledchromium-pa" > /bin-name && \
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
