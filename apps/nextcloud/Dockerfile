ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  NEXTCLOUD_VERSION=$(curl -sX GET "https://api.github.com/repos/nextcloud-releases/desktop/releases/latest" \
    | awk '/tag_name/{print $4;exit}' FS='[""]') && \
  cd /tmp && \
  curl -o \
    /tmp/nextcloud.app -L \
    "https://github.com/nextcloud-releases/desktop/releases/download/${NEXTCLOUD_VERSION}/Nextcloud-$(echo $NEXTCLOUD_VERSION | sed 's/^v//g')-x86_64.AppImage" && \
  chmod +x /tmp/nextcloud.app && \
  ./nextcloud.app --appimage-extract && \
  mv squashfs-root /opt/nextcloud && \
  echo "**** customize desktop file ****" && \
  DFILE=/opt/nextcloud/com.nextcloud.desktopclient.nextcloud.desktop && \
  DEST=/usr/share/applications/nextcloud-pa.desktop && \
  DKEEP=$(cat "${DFILE}" |sed '/^\(\Icon=\|Terminal=\|MimeType=\|Categories=\|Type=\|StartupNotify=\)/!d' |awk '!a[$0]++') && \
  echo '[Desktop Entry]' > "${DEST}" && \
  echo 'Name=Nextcloud Desktop PA' >> "${DEST}" && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':nextcloud %U"' >> "${DEST}" && \
  echo "${DKEEP}" >> "${DEST}" && \
  echo "nextcloud-pa" > /bin-name && \
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
