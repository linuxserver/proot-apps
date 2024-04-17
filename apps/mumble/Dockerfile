ARG REPO
FROM ghcr.io/${REPO}:alpine-319-av as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    mumble && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:mumble %U\"" \
    -e "s/Name=Mumble/Name=Mumble PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/info.mumble.Mumble.desktop && \
  mv \
    /usr/share/applications/info.mumble.Mumble.desktop \
    /usr/share/applications/mumble-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "mumble-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
