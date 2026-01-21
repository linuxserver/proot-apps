ARG REPO
FROM ghcr.io/${REPO}:alpine-323 AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    gimp && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:gimp %U\"" \
    -e "s/Name=GNU Image Manipulation Program/Name=GIMP PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/gimp.desktop && \
  mv \
    /usr/share/applications/gimp.desktop \
    /usr/share/applications/gimp-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "gimp-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
