ARG REPO
FROM ghcr.io/${REPO}:alpine-321 AS rootfs
ARG REPO

# add local files
COPY /root /

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    gtk4.0 \
    libadwaita \
    py3-gobject3 \
    py3-requests \
    py3-yaml \
    vte3 \
    vte3-gtk4 && \
  echo "**** customize files ****" && \
  sed -i \
    "s:linuxserver/proot-apps:${REPO}:g" \
    /usr/bin/proot-apps-gui && \
  sed -i \
    "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:gui %U\"" \
    /usr/share/applications/gui-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "gui-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
