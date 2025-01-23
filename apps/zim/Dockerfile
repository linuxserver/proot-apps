ARG REPO
FROM ghcr.io/${REPO}:alpine-321 AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    zim && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:zim %U\"" \
    -e "s/Name=Zim Desktop Wiki/Name=Zim Desktop Wiki PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/zim.desktop && \
  mv \
    /usr/share/applications/zim.desktop \
    /usr/share/applications/zim-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "zim-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
