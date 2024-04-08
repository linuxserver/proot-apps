ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm-av as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  ARCH=$(uname -m| sed 's/x86_64/amd64/g'| sed 's/aarch64/arm64/') && \
  BRAVE_DEB=$(curl -sL https://brave-browser-apt-release.s3.brave.com/dists/stable/main/binary-${ARCH}/Packages \
    | awk -F ': ' '/brave-browser*.*'${ARCH}'/ {print $2;exit}') && \
  BRAVE_KEY_DEB=$(curl -sL https://brave-browser-apt-release.s3.brave.com/dists/stable/main/binary-${ARCH}/Packages \
    | awk -F ': ' '/brave-keyring*.*deb/ {print $2;exit}') && \
  curl -o \
    /tmp/brave_key.deb -L \
    "https://brave-browser-apt-release.s3.brave.com/${BRAVE_KEY_DEB}" && \
  curl -o \
    /tmp/brave.deb \
    -L "https://brave-browser-apt-release.s3.brave.com/${BRAVE_DEB}" && \
  apt install -y --no-install-recommends \
    /tmp/brave_key.deb && \
  apt install -y --no-install-recommends \
    /tmp/brave.deb && \
  echo "**** customize desktop file ****" && \
  DFILE=/usr/share/applications/brave-browser.desktop && \
  DEST=/usr/share/applications/brave-browser-pa.desktop && \
  DKEEP=$(cat "${DFILE}" |sed '/^\(\Icon=\|Terminal=\|MimeType=\|Categories=\|Type=\|StartupNotify=\)/!d' |awk '!a[$0]++') && \
  echo '[Desktop Entry]' > "${DEST}" && \
  echo 'Name=Brave PA' >> "${DEST}" && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':brave %U"' >> "${DEST}" && \
  echo "${DKEEP}" >> "${DEST}" && \
  echo "**** set bin name ****" && \
  echo "brave-pa" > /bin-name && \
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
