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
  HATCHZIP_VERSION=$(curl -sX GET "https://api.github.com/repos/xevrion/hatchzip/releases/latest" \
    | jq -r '.tag_name') && \
  curl -o \
    /tmp/hatchzip.deb -L \
    "https://github.com/xevrion/hatchzip/releases/download/${HATCHZIP_VERSION}/hatchzip_amd64.deb" && \
  apt-get install -y --no-install-recommends \
    /tmp/hatchzip.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:hatchzip %f\"" \
    -e "s/^Name=HatchZip$/Name=HatchZip PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/io.github.xevrion.hatchzip.desktop && \
  mv \
    /usr/share/applications/io.github.xevrion.hatchzip.desktop \
    /usr/share/applications/hatchzip-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "hatchzip-pa" > /bin-name && \
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
