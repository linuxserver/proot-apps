ARG REPO
FROM ghcr.io/${REPO}:alpine-323 AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    moonlight-qt && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:moonlight %U\"" \
    -e "s/Name=Moonlight/Name=Moonlight PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/com.moonlight_stream.Moonlight.desktop && \
  mv \
    /usr/share/applications/com.moonlight_stream.Moonlight.desktop \
    /usr/share/applications/moonlight-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "moonlight-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
