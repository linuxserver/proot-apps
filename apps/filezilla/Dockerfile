ARG REPO
FROM ghcr.io/${REPO}:alpine-320 AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    filezilla && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:filezilla %U\"" \
    -e "s/Name=FileZilla/Name=FileZilla PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/filezilla.desktop && \
  mv \
    /usr/share/applications/filezilla.desktop \
    /usr/share/applications/filezilla-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "filezilla-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
