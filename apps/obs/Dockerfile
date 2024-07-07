ARG REPO
FROM ghcr.io/${REPO}:alpine-320 AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    ffmpeg \
    obs-studio && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:obs %U\"" \
    -e "s/Name=OBS Studio/Name=OBS PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/com.obsproject.Studio.desktop && \
  mv \
    /usr/share/applications/com.obsproject.Studio.desktop \
    /usr/share/applications/obs-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "obs-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
