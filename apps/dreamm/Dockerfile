ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libsdl2-2.0-0 && \
  ARCH=$(uname -m| sed 's/x86_64/x64/g'| sed 's/aarch64/arm64/') && \
  DREAMM_VERSION=$(curl -sL https://aarongiles.com/dreamm/ | \
    awk -F '(dreamm-|-linux-x64.tgz)' '/releases\\dreamm-.*-linux-x64.tgz/ {print $2}') && \
  curl -o \
    /tmp/dreamm.tgz -L \
    "https://aarongiles.com/dreamm/releases/dreamm-${DREAMM_VERSION}-linux-${ARCH}.tgz" && \
  mkdir -p \
    /opt/dreamm && \
  tar xf \
    /tmp/dreamm.tgz -C \
    /opt/dreamm && \
  echo "**** desktop file ****" && \
  mkdir -p \
    /usr/share/icons/hicolor/scalable/apps/ && \
  curl -o \
    /usr/share/icons/hicolor/scalable/apps/dreamm.svg \
    https://github.com/linuxserver/proot-apps/raw/master/metadata/img/dreamm.svg && \
  DESKTOP_FILE=/usr/share/applications/dreamm-pa.desktop && \
  echo '[Desktop Entry]' > ${DESKTOP_FILE} && \
  echo 'Type=Application' >> ${DESKTOP_FILE} && \
  echo 'Name=DREAMM PA' >> ${DESKTOP_FILE} && \
  echo 'Icon=dreamm' >> ${DESKTOP_FILE} && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':dreamm %U"' >> ${DESKTOP_FILE} && \
  echo "**** set bin name ****" && \
  echo "dreamm-pa" > /bin-name && \ 
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
