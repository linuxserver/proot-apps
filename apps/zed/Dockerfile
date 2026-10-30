ARG REPO
FROM ghcr.io/${REPO}:ubuntu-resolute AS rootfs
ARG REPO

# Add local files
COPY /root /

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libasound2t64 \
    libegl1 \
    libgl1 \
    libvulkan1 \
    libwayland-client0 \
    libwayland-egl1 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxkbcommon-x11-0 \
    libxkbcommon0 \
    mesa-vulkan-drivers && \
  ZED_VERSION=$(curl -sX GET "https://api.github.com/repos/zed-industries/zed/releases/latest" \
    | jq -r '.tag_name') && \
  curl -o \
    /tmp/zed.tar.gz -L \
    "https://github.com/zed-industries/zed/releases/download/${ZED_VERSION}/zed-linux-x86_64.tar.gz" && \
  mkdir -p /opt/zed && \
  tar xf \
    /tmp/zed.tar.gz -C \
    /opt/zed --strip-components=1 && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e '/^\[Desktop Action/,$d' \
    -e '/^Actions=/d' \
    -e '/^$/d' \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:zed %U\"" \
    -e "s/^Name=Zed$/Name=Zed PA/g" \
    -e '/^TryExec=/d' \
    /opt/zed/share/applications/dev.zed.Zed.desktop && \
  mv \
    /opt/zed/share/applications/dev.zed.Zed.desktop \
    /usr/share/applications/zed-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "zed-pa" > /bin-name && \
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
