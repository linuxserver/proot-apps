ARG REPO
FROM ghcr.io/${REPO}:alpine-323 AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    librewolf && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:librewolf %U\"" \
    -e "s/Name=LibreWolf/Name=LibreWolf PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/librewolf.desktop && \
  mv \
    /usr/share/applications/librewolf.desktop \
    /usr/share/applications/librewolf-pa.desktop && \
  curl -o \
    /usr/share/icons/hicolor/scalable/apps/librewolf.svg -L \
    https://upload.wikimedia.org/wikipedia/commons/d/d0/LibreWolf_icon.svg && \
  echo "**** set bin name ****" && \
  echo "librewolf-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
