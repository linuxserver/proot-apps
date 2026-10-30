ARG REPO
FROM ghcr.io/${REPO}:ubuntu-resolute AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libegl1 \
    libvulkan1 \
    libwayland-client0 \
    libwayland-egl1 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcursor1 \
    libxi6 \
    libxkbcommon-x11-0 \
    libxkbcommon0 \
    libxrandr2 \
    mesa-vulkan-drivers \
    xdg-desktop-portal \
    zenity && \
  BIMCRAFT_VERSION=$(curl -sX GET "https://api.github.com/repos/IPedrax/BIMCraft/releases/latest" \
    | jq -r '.tag_name') && \
  curl -o \
    /tmp/bimcraft.deb -L \
    "https://github.com/IPedrax/BIMCraft/releases/download/${BIMCRAFT_VERSION}/bimcraft-$(echo ${BIMCRAFT_VERSION}| sed 's/^v//g')-linux-$(uname -m).deb" && \
  apt-get install -y --no-install-recommends \
    /tmp/bimcraft.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:bimcraft %F\"" \
    -e "s/^Name=BIMCraft$/Name=BIMCraft PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/io.github.ipedrax.bimcraft.desktop && \
  mv \
    /usr/share/applications/io.github.ipedrax.bimcraft.desktop \
    /usr/share/applications/bimcraft-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "bimcraft-pa" > /bin-name && \
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
