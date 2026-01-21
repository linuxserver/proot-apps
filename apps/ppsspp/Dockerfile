ARG REPO
FROM ghcr.io/${REPO}:alpine-323 AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    ppsspp && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:ppsspp %U\"" \
    -e "s/Name=PPSSPPQt/Name=PPSSPPQt PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/PPSSPPQt.desktop && \
  mv \
    /usr/share/applications/PPSSPPQt.desktop \
    /usr/share/applications/ppsspp-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "ppsspp-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
