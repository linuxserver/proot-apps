ARG REPO
FROM ghcr.io/${REPO}:alpine-320 AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    kicad \
    kicad-library \
    kicad-library-3d \
    py3-wxpython && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:kicad %U\"" \
    -e "s/Name=KiCad/Name=KiCad PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/org.kicad.kicad.desktop && \
  mv \
    /usr/share/applications/org.kicad.kicad.desktop \
    /usr/share/applications/kicad-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "kicad-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
