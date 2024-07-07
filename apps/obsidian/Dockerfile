ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    git \
    libgtk-3-bin \
    libatk1.0 \
    libatk-bridge2.0 \
    libnss3 \
    python3-xdg && \
  OBSIDIAN_VERSION=$(curl -sX GET "https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest"| awk '/tag_name/{print $4;exit}' FS='[""]') && \
  OBSIDIAN_NOV=$(echo ${OBSIDIAN_VERSION} | sed 's/v//g') && \
  if [ "$(uname -m)" = "x86_64" ]; then \
    URL="https://github.com/obsidianmd/obsidian-releases/releases/download/${OBSIDIAN_VERSION}/Obsidian-${OBSIDIAN_NOV}.AppImage"; \
  else \
    URL="https://github.com/obsidianmd/obsidian-releases/releases/download/${OBSIDIAN_VERSION}/Obsidian-${OBSIDIAN_NOV}-arm64.AppImage"; \
  fi && \
  curl -o \
    /tmp/obsidian.app -L \
    "${URL}" && \
  chmod +x /tmp/obsidian.app && \
  cd /tmp && \
  ./obsidian.app --appimage-extract && `#This does not work in QEMU for arm64`\
  mv squashfs-root /opt/obsidian && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:obsidian %U\"" \
    -e "s/Name=Obsidian/Name=Obsidian PA/g" \
    -e '/^TryExec=/d' \
    /opt/obsidian/obsidian.desktop && \
  mv \
    /opt/obsidian/obsidian.desktop \
    /usr/share/applications/obsidian-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "obsidian-pa" > /bin-name && \
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
