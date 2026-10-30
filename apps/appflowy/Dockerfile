ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libatk-bridge2.0-0t64 \
    libatk1.0-0t64 \
    libatspi2.0-0t64 \
    libcairo-gobject2 \
    libcairo2 \
    libdbus-1-3 \
    libdrm2 \
    libegl1 \
    libepoxy0 \
    libgbm1 \
    libgdk-pixbuf-2.0-0 \
    libgl1 \
    libgles2 \
    libgstreamer-plugins-base1.0-0 \
    libgstreamer1.0-0 \
    libgtk-3-0t64 \
    libkeybinder-3.0-0 \
    libnotify4 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    librsvg2-2 \
    libwayland-client0 \
    libwayland-cursor0 \
    libwayland-egl1 \
    libx11-6 \
    libxcb-shm0 \
    libxcb1 \
    libxcursor1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxinerama1 \
    libxkbcommon0 \
    libxrandr2 && \
  APPFLOWY_VERSION=$(curl -sX GET "https://api.github.com/repos/AppFlowy-IO/AppFlowy/releases/latest" \
    | jq -r '.tag_name') && \
  curl -o \
    /tmp/appflowy.deb -L \
    "https://github.com/AppFlowy-IO/AppFlowy/releases/download/${APPFLOWY_VERSION}/AppFlowy-${APPFLOWY_VERSION}-linux-x86_64.deb" && \
  apt-get install -y --no-install-recommends \
    /tmp/appflowy.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:appflowy %U\"" \
    -e "s/^Name=AppFlowy$/Name=AppFlowy PA/g" \
    -e "s|^Icon=.*|Icon=appflowy|g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/AppFlowy.desktop && \
  mv \
    /usr/share/applications/AppFlowy.desktop \
    /usr/share/applications/appflowy-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "appflowy-pa" > /bin-name && \
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
