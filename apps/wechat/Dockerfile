ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libnss3 \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-render-util0 \
    libxcb-shape0 \
    libxcomposite1 \
    libxdamage1 \
    libxkbcommon0 \
    libxkbcommon-x11-0 && \
  ARCH=$(uname -m| sed 's/aarch64/arm64/') && \
  curl -o \
    /tmp/wechat.app -L \
    "https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_${ARCH}.AppImage" && \
  cd /tmp && \
  chmod +x /tmp/wechat.app && \
  ./wechat.app --appimage-extract && \
  mv squashfs-root /opt/wechat && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:wechat %U\"" \
    -e "s/Name=wechat/Name=wechat PA/g" \
    -e '/^TryExec=/d' \
    /opt/wechat/wechat.desktop && \
  mv \
    /opt/wechat/wechat.desktop \
    /usr/share/applications/wechat-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "wechat-pa" > /bin-name && \
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
