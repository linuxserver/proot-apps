ARG REPO
FROM ghcr.io/${REPO}:ubuntu-resolute AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libdecor-0-0 \
    libgl1 \
    libpulse0 \
    libwayland-cursor0 \
    libwayland-egl1 \
    libxcursor1 \
    libxi6 \
    libxinerama1 \
    libxkbcommon0 \
    libxrandr2 \
    unzip && \
  echo "**** install godot ****" && \
  ARCH=$(uname -m | sed 's/aarch64/arm64/g') && \
  GODOT_VERSION=$(curl -sX GET "https://api.github.com/repos/godotengine/godot/releases/latest" \
    | jq -er '.tag_name') && \
  curl -o \
    /tmp/godot.zip -L \
    "https://github.com/godotengine/godot/releases/download/${GODOT_VERSION}/Godot_v${GODOT_VERSION}_linux.${ARCH}.zip" && \
  unzip \
    /tmp/godot.zip -d \
    /tmp/godot && \
  mkdir -p /opt/godot && \
  mv \
    /tmp/godot/Godot_v${GODOT_VERSION}_linux.${ARCH} \
    /opt/godot/godot && \
  chmod +x /opt/godot/godot && \
  mkdir -p /usr/share/icons/hicolor/scalable/apps && \
  curl -o \
    /usr/share/icons/hicolor/scalable/apps/godot.svg -L \
    "https://raw.githubusercontent.com/godotengine/godot/${GODOT_VERSION}/misc/logo/icon.svg" && \
  echo "**** customize desktop file ****" && \
  curl -o \
    /usr/share/applications/godot-pa.desktop -L \
    "https://raw.githubusercontent.com/godotengine/godot/${GODOT_VERSION}/misc/dist/linux/org.godotengine.Godot.desktop" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:godot %f\"" \
    -e "s/^Name=Godot Engine/Name=Godot Engine PA/" \
    /usr/share/applications/godot-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "godot-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  apt-get remove -y unzip && \
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
