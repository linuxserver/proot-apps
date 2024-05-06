ARG REPO
FROM ghcr.io/${REPO}:alpine-319 as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    dolphin-emu && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:dolphin %U\"" \
    -e "s/Name=Dolphin Emulator/Name=Dolphin Emulator PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/dolphin-emu.desktop && \
  mv \
    /usr/share/applications/dolphin-emu.desktop \
    /usr/share/applications/dolphin-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "dolphin-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
