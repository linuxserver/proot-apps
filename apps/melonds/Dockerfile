ARG REPO
FROM ghcr.io/${REPO}:alpine-321 AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    melonds && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:melonds %U\"" \
    -e "s/Name=melonDS/Name=melonDS PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/net.kuribo64.melonDS.desktop && \
  mv \
    /usr/share/applications/net.kuribo64.melonDS.desktop \
    /usr/share/applications/melonds-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "melonds-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
