ARG REPO
FROM ghcr.io/${REPO}:alpine-320 as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    gnome-weather && \
  echo "**** customize desktop file ****" && \
  DESKTOP_FILE=/usr/share/applications/weather-pa.desktop && \
  echo '[Desktop Entry]' > ${DESKTOP_FILE} && \
  echo 'Type=Application' >> ${DESKTOP_FILE} && \
  echo 'Name=Weather PA' >> ${DESKTOP_FILE} && \
  echo 'Icon=org.gnome.Weather' >> ${DESKTOP_FILE} && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':weather %U"' >> ${DESKTOP_FILE} && \
  echo "**** set bin name ****" && \
  echo "weather-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
