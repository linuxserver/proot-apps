ARG REPO
FROM ghcr.io/${REPO}:alpine-320 AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    geany && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:geany %U\"" \
    -e "s/Name=Geany/Name=Geany PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/geany.desktop && \
  mv \
    /usr/share/applications/geany.desktop \
    /usr/share/applications/geany-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "geany-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
