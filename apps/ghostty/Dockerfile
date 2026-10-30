ARG REPO
FROM ghcr.io/${REPO}:ubuntu-resolute AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  GHOSTTY_VERSION=$(curl -sX GET "https://api.github.com/repos/pkgforge-dev/ghostty-appimage/releases/latest" \
    | jq -r '.tag_name') && \
  curl -o \
    /tmp/ghostty.app -L \
    "https://github.com/pkgforge-dev/ghostty-appimage/releases/download/${GHOSTTY_VERSION}/Ghostty-$(echo ${GHOSTTY_VERSION}| sed 's/^v//g')-x86_64.AppImage" && \
  chmod +x /tmp/ghostty.app && \
  cd /tmp && \
  ./ghostty.app --appimage-extract && \
  mv "$(readlink -f /tmp/squashfs-root)" /opt/ghostty && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e '/^\[Desktop Action/,$d' \
    -e '/^Actions=/d' \
    -e '/^$/d' \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:ghostty\"" \
    -e "s/^Name=Ghostty$/Name=Ghostty PA/g" \
    -e '/^TryExec=/d' \
    /opt/ghostty/com.mitchellh.ghostty.desktop && \
  mv \
    /opt/ghostty/com.mitchellh.ghostty.desktop \
    /usr/share/applications/ghostty-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "ghostty-pa" > /bin-name && \
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
