ARG REPO
FROM ghcr.io/${REPO}:ubuntu-resolute AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    scummvm && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:scummvm %U\"" \
    -e "s/^Name=.*/Name=ScummVM PA/" \
    -e '/^TryExec=/d' \
    /usr/share/applications/org.scummvm.scummvm.desktop && \
  mv \
    /usr/share/applications/org.scummvm.scummvm.desktop \
    /usr/share/applications/scummvm-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "scummvm-pa" > /bin-name && \
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
