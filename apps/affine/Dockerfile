ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS rootfs
ARG REPO

# Add local files
COPY /root /

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libasound2t64 \
    libatk1.0-0t64 \
    libatk-bridge2.0-0t64 \
    libcups2 \
    libdrm2 \
    libgbm1 \
    libgtk-3-0t64 \
    libnss3 \
    libxcomposite1 \
    libxdamage1 \
    libxkbcommon0 \
    libxrandr2 && \
  AFFINE_VERSION=$(curl -sX GET "https://api.github.com/repos/toeverything/AFFiNE/releases/latest" \
    | jq -r '.tag_name') && \
  URL="https://github.com/toeverything/AFFiNE/releases/download/${AFFINE_VERSION}/affine-$(echo ${AFFINE_VERSION} | sed 's/^v//g')-stable-linux-x64.appimage" && \
  curl -o \
    /tmp/affine.app -L \
    "${URL}" && \
  chmod +x /tmp/affine.app && \
  cd /tmp && \
  ./affine.app --appimage-extract && \
  mv squashfs-root /opt/affine && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:affine %U\"" \
    -e "s/^Name=AFFiNE$/Name=AFFiNE PA/g" \
    -e 's/^Icon=affine-electron$/Icon=affine/g' \
    -e '/^X-AppImage-/d' \
    -e '/^TryExec=/d' \
    /opt/affine/AFFiNE.desktop && \
  mv \
    /opt/affine/AFFiNE.desktop \
    /usr/share/applications/affine-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "affine-pa" > /bin-name && \
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
