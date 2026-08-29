ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS build

# Build dolphin
RUN \
  echo "**** install build deps ****" && \
  apt-get update && \
  apt-get install -y \
    build-essential \
    cmake \
    git \
    libavcodec-dev \
    libavformat-dev \
    libavutil-dev \
    libcurl4-openssl-dev \
    libegl1-mesa-dev \
    libevdev-dev \
    libpulse-dev \
    libqt6svg6-dev \
    libswscale-dev \
    libudev-dev \
    libvulkan-dev \
    libx11-dev \
    libxi-dev \
    libxrandr-dev \
    pkg-config \
    qt6-base-dev \
    qt6-base-private-dev \
    qt6-wayland-dev \
    qt6-wayland-private-dev && \
  echo "**** build dolphin ****" && \
  DOLPHIN_VERSION=$(curl -sL 'https://raw.githubusercontent.com/flathub/org.DolphinEmu.dolphin-emu/refs/heads/master/org.DolphinEmu.dolphin-emu.metainfo.xml' \
    | awk -F'(<release version="|")' '/release version/ {print $2;exit}') && \
  mkdir /root-out && \
  git clone https://github.com/dolphin-emu/dolphin.git /tmp/dolphin && \
  cd /tmp/dolphin && \
  echo "**** building dolphin at ${DOLPHIN_VERSION} ****" && \
  git checkout -f ${DOLPHIN_VERSION} && \
  git submodule update --init --recursive && \
  mkdir build && \
  cd build && \
  cmake .. && \
  make -j$(nproc) && \
  make install DESTDIR=/root-out

FROM ghcr.io/${REPO}:debian-trixie AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libavcodec61 \
    libavformat61 \
    libqt6widgets6 \
    libswscale8 \
    libxi6 \
    qt6-svg-plugins \
    qt6-wayland && \
  echo "**** cleanup ****" && \
  apt-get autoclean && \
  rm -rf \
    /root/.cache \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*

COPY --from=build /root-out /

RUN \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:dolphin %U\"" \
    -e "s/Name=Dolphin Emulator/Name=Dolphin Emulator PA/g" \
    -e '/^TryExec=/d' \
    /usr/local/share/applications/dolphin-emu.desktop && \
  mv \
    /usr/local/share/applications/dolphin-emu.desktop \
    /usr/share/applications/dolphin-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "dolphin-pa" > /bin-name

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
