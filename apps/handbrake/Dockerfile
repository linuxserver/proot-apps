ARG REPO
FROM ghcr.io/${REPO}:debian-sid as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y  \
    handbrake && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:handbrake %U\"" \
    -e "s/Name=HandBrake/Name=HandBrake PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/fr.handbrake.ghb.desktop && \
  mv \
    /usr/share/applications/fr.handbrake.ghb.desktop \
    /usr/share/applications/handbrake-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "handbrake-pa" > /bin-name && \
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
