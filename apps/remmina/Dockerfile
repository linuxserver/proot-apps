ARG REPO
FROM ghcr.io/${REPO}:alpine-320 as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    icu-data-full \
    remmina && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:remmina %U\"" \
    -e "s/Name=Remmina/Name=Remmina PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/org.remmina.Remmina.desktop && \
  mv \
    /usr/share/applications/org.remmina.Remmina.desktop \
    /usr/share/applications/remmina-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "remmina-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
