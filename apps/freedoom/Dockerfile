ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y  \
    freedoom && \
  echo "**** customize desktop file ****" && \
  for APP in Phase1 Phase2; do \
    sed -i \
      -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:freedoom ${APP} %U\"" \
      -e "s/Name=Phase.*/Name=Freedoom ${APP} PA/g" \
      -e '/^TryExec=/d' \
      /usr/share/applications/io.github.freedoom.${APP}.desktop; \
    mv \
      /usr/share/applications/io.github.freedoom.${APP}.desktop \
      /usr/share/applications/freedoom-${APP}-pa.desktop; \
  done && \
  echo "**** set bin name ****" && \
  echo "freedoom-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  apt-get autoclean && \
  rm -rf \
    /root/.cache \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
