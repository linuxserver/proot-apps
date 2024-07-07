ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libnss3 && \
  curl -o \
    /tmp/zoom.deb -L \
    "https://zoom.us/client/latest/zoom_amd64.deb" && \
  apt install -y --no-install-recommends \
    /tmp/zoom.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:zoom %U\"" \
    -e "s/Name=Zoom/Name=Zoom PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/Zoom.desktop && \
  mv \
    /usr/share/applications/Zoom.desktop \
    /usr/share/applications/zoom-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "zoom-pa" > /bin-name && \
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
