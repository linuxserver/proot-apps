ARG REPO
FROM ghcr.io/${REPO}:ubuntu-resolute AS rootfs
ARG REPO

# Graphics drivers for pressure-vessel to import, 64 and 32 bit
RUN \
  echo "**** install packages ****" && \
  dpkg --add-architecture i386 && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    libc6:i386 \
    libegl-mesa0 \
    libegl-mesa0:i386 \
    libegl1 \
    libegl1:i386 \
    libgbm1 \
    libgbm1:i386 \
    libgl1 \
    libgl1:i386 \
    libgl1-mesa-dri \
    libgl1-mesa-dri:i386 \
    libgles2 \
    libgles2:i386 \
    libglx-mesa0 \
    libglx-mesa0:i386 \
    libva-drm2 \
    libva-drm2:i386 \
    libva-x11-2 \
    libva-x11-2:i386 \
    libva2 \
    libva2:i386 \
    libvulkan1 \
    libvulkan1:i386 \
    mesa-libgallium \
    mesa-libgallium:i386 \
    mesa-va-drivers \
    mesa-va-drivers:i386 \
    mesa-vulkan-drivers \
    mesa-vulkan-drivers:i386 \
    unzip && \
  echo "**** desktop entry and icons from the steam launcher ****" && \
  curl -o \
    /tmp/steam.deb -fL \
    https://repo.steampowered.com/steam/archive/stable/steam_latest.deb && \
  dpkg-deb -x /tmp/steam.deb /tmp/steam && \
  mkdir -p /usr/share/icons/hicolor && \
  cp -a \
    /tmp/steam/usr/share/icons/hicolor/. \
    /usr/share/icons/hicolor/ && \
  sed \
    -e 's|^Exec=/usr/bin/steam\(.*\)$|Exec=/bin/sh -c "$HOME/.local/bin/steam-pa\1"|' \
    -e 's|^Name=Steam$|Name=Steam PA|' \
    /tmp/steam/usr/share/applications/steam.desktop \
    > /usr/share/applications/steam-pa.desktop && \
  echo "**** set bin name and rootfs name ****" && \
  echo "steam-pa" > /bin-name && \
  echo "ghcr.io_$(echo "${REPO}" | sed 's|/|_|g')_steam" > /rootfs-name && \
  echo "**** cleanup ****" && \
  apt-get autoclean && \
  rm -rf \
    /root/.cache \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*

COPY ./bootstrap /bootstrap
COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./launch /launch
COPY ./remove /remove
COPY ./steam-launch-shell /steam-launch-shell

FROM scratch
COPY --from=rootfs / /
