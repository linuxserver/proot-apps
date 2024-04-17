ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm-av as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libqt5printsupport5 \
    libqt5x11extras5 \
    xz-utils && \
  DOUBLECMD_VERSION=$(curl -sX GET "https://api.github.com/repos/doublecmd/doublecmd/releases/latest" \
    | awk '/tag_name/{print $4;exit}' FS='[""]') && \
  curl -o \
    /tmp/doublecmd.tar.xz -L \
    "https://github.com/doublecmd/doublecmd/releases/download/${DOUBLECMD_VERSION}/doublecmd-$(echo $DOUBLECMD_VERSION| sed 's/^v//g').qt.$(uname -m).tar.xz" && \
  mkdir /opt/doublecmd && \
  tar -xf \
    /tmp/doublecmd.tar.xz -C \
    /opt/doublecmd --strip-components=1 && \ 
  echo "**** desktop file ****" && \
  DESKTOP_FILE=/usr/share/applications/doublecmd-pa.desktop && \
  echo '[Desktop Entry]' > ${DESKTOP_FILE} && \
  echo 'Type=Application' >> ${DESKTOP_FILE} && \
  echo 'Name=Double Commander PA' >> ${DESKTOP_FILE} && \
  echo 'Icon=doublecmd' >> ${DESKTOP_FILE} && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':doublecmd %U"' >> ${DESKTOP_FILE} && \
  echo "**** set bin name ****" && \
  echo "doublecmd-pa" > /bin-name && \
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
