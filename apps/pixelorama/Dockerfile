ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libasound2t64 \
    libdbus-1-3 \
    libdecor-0-0 \
    libegl1 \
    libfontconfig1 \
    libgl1 \
    libgles2 \
    libpulse0 \
    libudev1 \
    libwayland-client0 \
    libwayland-cursor0 \
    libwayland-egl1 \
    libxcursor1 \
    libxi6 \
    libxinerama1 \
    libxkbcommon0 \
    libxrandr2 && \
  echo "**** install pixelorama ****" && \
  PIXELORAMA_VERSION=$(curl -sX GET "https://api.github.com/repos/Orama-Interactive/Pixelorama/releases/latest" \
    | jq -r '.tag_name') && \
  curl -o \
    /tmp/pixelorama.tar.gz -L \
    "https://github.com/Orama-Interactive/Pixelorama/releases/download/${PIXELORAMA_VERSION}/Pixelorama-Linux-64bit.tar.gz" && \
  mkdir -p /opt/pixelorama && \
  tar xf \
    /tmp/pixelorama.tar.gz -C \
    /opt/pixelorama --strip-components=1 && \
  chmod +x /opt/pixelorama/Pixelorama.x86_64 && \
  mkdir -p /usr/share/icons/hicolor/256x256/apps && \
  curl -o \
    /usr/share/icons/hicolor/256x256/apps/pixelorama.png -L \
    "https://raw.githubusercontent.com/Orama-Interactive/Pixelorama/${PIXELORAMA_VERSION}/assets/graphics/icons/icon.png" && \
  echo "**** customize desktop file ****" && \
  curl -o \
    /usr/share/applications/pixelorama-pa.desktop -L \
    "https://raw.githubusercontent.com/Orama-Interactive/Pixelorama/${PIXELORAMA_VERSION}/Misc/Linux/com.orama_interactive.Pixelorama.desktop" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:pixelorama %u\"" \
    -e "s/^Name=Pixelorama$/Name=Pixelorama PA/" \
    -e '/^TryExec=/d' \
    /usr/share/applications/pixelorama-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "pixelorama-pa" > /bin-name && \
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
