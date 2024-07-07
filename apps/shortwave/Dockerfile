ARG REPO
FROM ghcr.io/${REPO}:alpine-320 AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    gnome-shortwave  && \
  echo "**** customize desktop file ****" && \
  echo '[Desktop Entry]' > /usr/share/applications/shortwave-pa.desktop && \
  echo 'Name=Shortwave PA' >> /usr/share/applications/shortwave-pa.desktop && \
  echo 'Icon=de.haeckerfelix.Shortwave' >> /usr/share/applications/shortwave-pa.desktop && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':shortwave %U"' >> /usr/share/applications/shortwave-pa.desktop && \
  echo 'Terminal=false' >> /usr/share/applications/shortwave-pa.desktop && \
  echo 'Type=Application' >> /usr/share/applications/shortwave-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "shortwave-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
