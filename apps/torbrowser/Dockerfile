ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    file \
    libasound2t64 \
    libdbus-glib-1-2 \
    libegl1 \
    libgl1 \
    libgtk-3-0t64 \
    libpci3 \
    libpulse0 \
    libx11-xcb1 \
    libxt6t64 \
    libxtst6 \
    xz-utils && \
  echo "**** install tor browser ****" && \
  URL=$(curl -sL \
    "https://aus1.torproject.org/torbrowser/update_3/release/downloads.json" \
    | jq -r '.downloads["linux-x86_64"].ALL.binary') && \
  curl -o \
    /tmp/tor-browser.tar.xz -L \
    "${URL}" && \
  mkdir -p /opt/tor-browser && \
  tar -xf \
    /tmp/tor-browser.tar.xz -C \
    /opt/tor-browser --strip-components=1 && \
  touch /opt/tor-browser/Browser/is-packaged-app && \
  echo "**** customize desktop file ****" && \
  mkdir -p /usr/share/icons/hicolor/128x128/apps && \
  cp \
    /opt/tor-browser/Browser/browser/chrome/icons/default/default128.png \
    /usr/share/icons/hicolor/128x128/apps/torbrowser.png && \
  chmod 644 /usr/share/icons/hicolor/128x128/apps/torbrowser.png && \
  echo '[Desktop Entry]' > /usr/share/applications/torbrowser-pa.desktop && \
  echo 'Type=Application' >> /usr/share/applications/torbrowser-pa.desktop && \
  echo 'Name=Tor Browser PA' >> /usr/share/applications/torbrowser-pa.desktop && \
  echo 'GenericName=Web Browser' >> /usr/share/applications/torbrowser-pa.desktop && \
  echo 'Comment=Tor Browser is a privacy-focused web browser designed to minimize tracking and fingerprinting, using the Tor network to protect your privacy and anonymity.' >> /usr/share/applications/torbrowser-pa.desktop && \
  echo 'Icon=torbrowser' >> /usr/share/applications/torbrowser-pa.desktop && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':torbrowser %U"' >> /usr/share/applications/torbrowser-pa.desktop && \
  echo 'Categories=Network;WebBrowser;Security;' >> /usr/share/applications/torbrowser-pa.desktop && \
  echo 'StartupNotify=true' >> /usr/share/applications/torbrowser-pa.desktop && \
  echo 'StartupWMClass=Tor Browser' >> /usr/share/applications/torbrowser-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "torbrowser-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  apt-get remove -y \
    xz-utils && \
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
