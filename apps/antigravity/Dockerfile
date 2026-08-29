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
    git \
    gnupg2 \
    libasound2t64 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libatspi2.0-0 \
    libcairo2 \
    libcups2 \
    libcurl4t64 \
    libdbus-1-3 \
    libdrm2 \
    libexpat1 \
    libgbm1 \
    libglib2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libpango-1.0-0 \
    libsecret-1-0 \
    libx11-6 \
    libxcomposite1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxkbcommon0 \
    libxkbfile1 \
    libxrandr2 \
    openssh-client && \
  ARCH=$(uname -m| sed 's/x86_64/linux-x64/g'| sed 's/aarch64/linux-arm64/') && \
  URL=$(curl -sL \
    "https://antigravity-ide-auto-updater-974169037036.us-central1.run.app/api/update/${ARCH}/stable/latest" \
    | jq -r '.url' | sed 's/ /%20/g') && \
  curl -o \
    /tmp/antigravity.tar.gz -L \
    "${URL}" && \
  mkdir -p /tmp/antigravity && \
  tar -xf \
    /tmp/antigravity.tar.gz -C \
    /tmp/antigravity --strip-components=1 && \
  mv /tmp/antigravity /opt/antigravity && \
  echo "**** customize desktop file ****" && \
  echo '[Desktop Entry]' > /usr/share/applications/antigravity-pa.desktop && \
  echo 'Type=Application' >> /usr/share/applications/antigravity-pa.desktop && \
  echo 'Name=Antigravity PA' >> /usr/share/applications/antigravity-pa.desktop && \
  echo 'Icon=antigravity' >> /usr/share/applications/antigravity-pa.desktop && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':antigravity %U"' >> /usr/share/applications/antigravity-pa.desktop && \
  echo 'Comment=Google Antigravity IDE' >> /usr/share/applications/antigravity-pa.desktop && \
  echo 'Categories=Development;IDE;' >> /usr/share/applications/antigravity-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "antigravity-pa" > /bin-name && \
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
