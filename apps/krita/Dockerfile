ARG REPO
FROM ghcr.io/${REPO}:alpine-320 AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    krita && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:krita %U\"" \
    -e "s/Name=Krita/Name=Krita PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/org.kde.krita.desktop && \
  mv \
    /usr/share/applications/org.kde.krita.desktop \
    /usr/share/applications/krita-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "krita-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
