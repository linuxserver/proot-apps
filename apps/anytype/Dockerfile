ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libasound2t64 \
    libayatana-appindicator3-1 \
    libatk1.0-0t64 \
    libatk-bridge2.0-0t64 \
    libcups2 \
    libdrm2 \
    libgbm1 \
    libgtk-3-0t64 \
    libnss3 \
    libsecret-1-0 \
    libxcomposite1 \
    libxdamage1 \
    libxkbcommon0 \
    libxrandr2 && \
  ANYTYPE_VERSION=$(curl -sX GET "https://api.github.com/repos/anyproto/anytype-ts/releases/latest" \
    | jq -r '.tag_name') && \
  URL="https://github.com/anyproto/anytype-ts/releases/download/${ANYTYPE_VERSION}/Anytype-$(echo ${ANYTYPE_VERSION} | sed 's/^v//g').AppImage" && \
  curl -o \
    /tmp/anytype.app -L \
    "${URL}" && \
  chmod +x /tmp/anytype.app && \
  cd /tmp && \
  ./anytype.app --appimage-extract && \
  mv squashfs-root /opt/anytype && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:anytype %U\"" \
    -e "s/^Name=Anytype$/Name=Anytype PA/g" \
    -e '/^X-AppImage-Version=/d' \
    -e '/^TryExec=/d' \
    /opt/anytype/anytype.desktop && \
  mv \
    /opt/anytype/anytype.desktop \
    /usr/share/applications/anytype-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "anytype-pa" > /bin-name && \
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
