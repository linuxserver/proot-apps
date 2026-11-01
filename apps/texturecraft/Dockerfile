ARG REPO
FROM ghcr.io/${REPO}:ubuntu-resolute AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libdbus-1-3 \
    libegl1 \
    libvulkan1 \
    libwayland-client0 \
    libwayland-egl1 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcursor1 \
    libxi6 \
    libxkbcommon-x11-0 \
    libxkbcommon0 \
    libxrandr2 \
    mesa-vulkan-drivers \
    xdg-desktop-portal \
    zenity && \
  TEXTURECRAFT_VERSION=$(curl -sX GET "https://api.github.com/repos/storytold/texturecraft/releases/latest" \
    | jq -r '.tag_name') && \
  curl -o \
    /tmp/texturecraft.deb -L \
    "https://github.com/storytold/texturecraft/releases/download/${TEXTURECRAFT_VERSION}/texturecraft-$(echo ${TEXTURECRAFT_VERSION}| sed 's/^v//g')-linux-$(uname -m).deb" && \
  apt-get install -y --no-install-recommends \
    /tmp/texturecraft.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:texturecraft %F\"" \
    -e "s/^Name=TextureCraft$/Name=TextureCraft PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/ai.storyteller.texturecraft.desktop && \
  mv \
    /usr/share/applications/ai.storyteller.texturecraft.desktop \
    /usr/share/applications/texturecraft-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "texturecraft-pa" > /bin-name && \
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
