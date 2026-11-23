ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** add Signal GPG key ****" && \
  mkdir -p /etc/apt/keyrings && \
  curl -o \
    /etc/apt/keyrings/signal-desktop.asc -L \
    "https://updates.signal.org/desktop/apt/keys.asc" && \
  echo "**** add Signal apt repository ****" && \
  echo \
    "deb [arch=amd64 signed-by=/etc/apt/keyrings/signal-desktop.asc] https://updates.signal.org/desktop/apt xenial main" > \
    /etc/apt/sources.list.d/signal-xenial.list && \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    signal-desktop && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:signal %U\"" \
    -e "s/Name=Signal/Name=Signal PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/signal-desktop.desktop && \
  mv \
    /usr/share/applications/signal-desktop.desktop \
    /usr/share/applications/signal-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "signal-pa" > /bin-name && \
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
