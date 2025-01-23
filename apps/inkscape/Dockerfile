ARG REPO
FROM ghcr.io/${REPO}:alpine-321 AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    inkscape && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:inkscape %U\"" \
    -e "s/Name=Inkscape/Name=Inkscape PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/org.inkscape.Inkscape.desktop && \
  mv \
    /usr/share/applications/org.inkscape.Inkscape.desktop \
    /usr/share/applications/inkscape-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "inkscape-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
