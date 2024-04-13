ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm-av as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  curl -o \
    /tmp/libjpeg.deb -L \
    "https://archive.debian.org/debian/pool/main/libj/libjpeg8/libjpeg8_8b-1_amd64.deb" && \
  curl -o \
    /tmp/parsec.deb -L \
    "https://builds.parsec.app/package/parsec-linux.deb" && \
  dpkg -i \
   /tmp/libjpeg.deb && \ 
  apt install -y --no-install-recommends \
    /tmp/parsec.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:parsec %U\"" \
    -e "s/Name=Parsec/Name=Parsec PA/g" \
    -e 's:Icon=/usr/share/icons/hicolor/256x256/apps/parsecd.png:Icon=parsecd:g' \
    -e '/^TryExec=/d' \
    /usr/share/applications/parsecd.desktop && \
  mv \
    /usr/share/applications/parsecd.desktop \
    /usr/share/applications/parsec-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "parsec-pa" > /bin-name && \
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
