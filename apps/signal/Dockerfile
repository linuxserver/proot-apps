ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm-av as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  SIGNAL_DEB=$(curl -sL https://updates.signal.org/desktop/apt/dists/xenial/main/binary-amd64/Packages | \
    awk -F ': ' '/signal-desktop*.*deb/ {print $2}' | \
    grep -v '\-beta' | \
    head -1) && \
  curl -o \
    /tmp/signal.deb -L \
    "https://updates.signal.org/desktop/apt/${SIGNAL_DEB}" && \
  apt install -y --no-install-recommends \
    /tmp/signal.deb && \
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
