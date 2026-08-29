ARG REPO
FROM ghcr.io/${REPO}:ubuntu-noble AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libarchive13t64 \
    libenet7 \
    libfaad2 \
    libpcap0.8t64 \
    libqt6multimedia6 \
    libqt6opengl6 \
    libqt6svg6 \
    libqt6widgets6 \
    libsdl2-2.0-0 \
    libzstd1 \
    qt6-wayland \
    unzip && \
  echo "**** install melonds ****" && \
  MELONDS_VERSION=$(curl -sX GET "https://api.github.com/repos/melonDS-emu/melonDS/releases/latest" \
    | jq -r '.tag_name') && \
  curl -o \
    /tmp/melon.zip -L \
    "https://github.com/melonDS-emu/melonDS/releases/download/${MELONDS_VERSION}/melonDS-${MELONDS_VERSION}-ubuntu-$(uname -m).zip" && \
  cd /tmp && \
  unzip melon.zip && \
  mv \
    melonDS \
    /usr/bin && \
  mkdir -p \
    /usr/share/icons/hicolor/256x256/apps \
    /usr/share/applications && \
  curl -o \
    /usr/share/icons/hicolor/256x256/apps/net.kuribo64.melonDS.png -L \
    "https://raw.githubusercontent.com/melonDS-emu/melonDS/${MELONDS_VERSION}/res/icon/melon_256x256.png" && \
  curl -o \
    /usr/share/applications/net.kuribo64.melonDS.desktop -L \
    "https://raw.githubusercontent.com/melonDS-emu/melonDS/${MELONDS_VERSION}/res/net.kuribo64.melonDS.desktop" && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:melonds %U\"" \
    -e "s/Name=melonDS/Name=melonDS PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/net.kuribo64.melonDS.desktop && \
  mv \
    /usr/share/applications/net.kuribo64.melonDS.desktop \
    /usr/share/applications/melonds-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "melonds-pa" > /bin-name && \
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
