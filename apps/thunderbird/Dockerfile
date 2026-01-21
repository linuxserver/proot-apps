ARG REPO
FROM ghcr.io/${REPO}:alpine-323 AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    thunderbird && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:thunderbird %U\"" \
    -e "s/Name=Thunderbird/Name=Thunderbird PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/thunderbird.desktop && \
  mv \
    /usr/share/applications/thunderbird.desktop \
    /usr/share/applications/thunderbird-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "thunderbird-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
