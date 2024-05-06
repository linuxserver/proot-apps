ARG REPO
FROM ghcr.io/${REPO}:alpine-edge as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    firefox-developer-edition && \
  echo "**** customize desktop file ****" && \
  DFILE=/usr/share/applications/firefox-developer-edition.desktop && \
  DEST=/usr/share/applications/firefox-developer-edition-pa.desktop && \
  DKEEP=$(cat "${DFILE}" |sed '/^\(\Icon=\|Terminal=\|MimeType=\|Categories=\|Type=\|StartupNotify=\)/!d' |awk '!a[$0]++') && \
  echo '[Desktop Entry]' > "${DEST}" && \
  echo 'Name=Firefox Dev PA' >> "${DEST}" && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':firefox-dev %U"' >> "${DEST}" && \
  echo "${DKEEP}" >> "${DEST}" && \
  echo "**** set bin name ****" && \
  echo "firefox-dev-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
