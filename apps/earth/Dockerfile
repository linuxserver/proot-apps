ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libsqlite3-0 \
    libxcomposite1 \
    libxi6 && \
  curl -o \
    /tmp/earth.deb -L \
    "https://dl.google.com/dl/earth/client/current/google-earth-pro-stable_current_amd64.deb" && \
  apt install -y --no-install-recommends \
    /tmp/earth.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:earth %U\"" \
    -e "s/Name=Google Earth/Name=Google Earth PA/g" \
    -e '/^TryExec=/d' \
    /opt/google/earth/pro/google-earth-pro.desktop && \
  mv \
    /opt/google/earth/pro/google-earth-pro.desktop \
    /usr/share/applications/earth-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "earth-pa" > /bin-name && \
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
