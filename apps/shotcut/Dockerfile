ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    ffmpeg \
    shotcut && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:shotcut %U\"" \
    -e "s/Name=Shotcut/Name=Shotcut PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/org.shotcut.Shotcut.desktop && \
  mv \
    /usr/share/applications/org.shotcut.Shotcut.desktop \
    /usr/share/applications/shotcut-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "shotcut-pa" > /bin-name && \
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
