ARG REPO
FROM ghcr.io/${REPO}:alpine-319 as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    breeze-icons5 \
    digikam \
    exiftool \
    imagemagick \
    mariadb \
    mariadb-client \
    mariadb-server-utils \
    openexr \
    perl-image-exiftool \
    qt5-qtbase-sqlite && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:digikam %U\"" \
    -e "s/Name=digiKam/Name=digiKam PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/org.kde.digikam.desktop && \
  mv \
    /usr/share/applications/org.kde.digikam.desktop \
    /usr/share/applications/digikam-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "digikam-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
