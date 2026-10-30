ARG REPO
FROM ghcr.io/${REPO}:ubuntu-resolute AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    fontconfig \
    libasound2t64 \
    libegl1 \
    libgl1 \
    liblzma5 \
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
    zlib1g && \
  curl -o \
    /tmp/warp.deb -L \
    "https://app.warp.dev/download?package=deb" && \
  apt-get install -y --no-install-recommends \
    /tmp/warp.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:warp %U\"" \
    -e "s/^Name=Warp$/Name=Warp PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/dev.warp.Warp.desktop && \
  mv \
    /usr/share/applications/dev.warp.Warp.desktop \
    /usr/share/applications/warp-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "warp-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -f \
    /etc/apt/sources.list.d/warpdotdev.list \
    /etc/apt/sources.list.d/warpdotdev.sources \
    /etc/apt/trusted.gpg.d/warpdotdev.gpg && \
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
