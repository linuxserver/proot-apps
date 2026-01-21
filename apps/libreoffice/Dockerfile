ARG REPO
FROM ghcr.io/${REPO}:alpine-323 AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    libreoffice \
    openjdk8-jre && \
  echo "**** customize desktop files ****" && \
  for APP in base calc draw impress math writer; do \
    sed -i \
      -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:libreoffice --${APP} %U\"" \
      -e "s/Name=LibreOffice.*/Name=$(echo "$APP" | awk '{for(i=1;i<=NF;i++){ $i=toupper(substr($i,1,1)) substr($i,2) }}1') PA/g" \
      -e '/^TryExec=/d' \
      /usr/lib/libreoffice/share/xdg/${APP}.desktop; \
    mv \
      /usr/lib/libreoffice/share/xdg/${APP}.desktop \
      /usr/lib/libreoffice/share/xdg/${APP}-pa.desktop; \
  done && \
  echo "**** set bin name ****" && \
  echo "libreoffice-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
