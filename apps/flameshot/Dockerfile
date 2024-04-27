ARG REPO
FROM ghcr.io/${REPO}:alpine-edge-av as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    flameshot && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:flameshot %U\"" \
    -e "s/Name=Flameshot/Name=Flameshot PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/org.flameshot.Flameshot.desktop && \
  mv \
    /usr/share/applications/org.flameshot.Flameshot.desktop \
    /usr/share/applications/flameshot-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "flameshot-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
