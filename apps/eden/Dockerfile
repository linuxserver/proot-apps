ARG REPO
FROM ghcr.io/${REPO}:ubuntu-resolute AS build

# Build eden
RUN \
  echo "**** install build deps ****" && \
  apt-get update && \
  apt-get install -y \
    autoconf \
    cmake \
    g++ \
    gcc \
    git \
    glslang-tools \
    libasound2t64 \
    libavcodec-dev \
    libavfilter-dev \
    libboost-context-dev \
    libboost-fiber-dev \
    libcpp-httplib-dev \
    libcpp-jwt-dev \
    libcubeb-dev \
    libenet-dev \
    libfmt-dev \
    libglu1-mesa-dev \
    libhidapi-dev \
    liblz4-dev \
    libopus-dev \
    libpulse-dev \
    libqt6core5compat6 \
    libquazip1-qt6-dev \
    libsdl2-dev \
    libsimpleini-dev \
    libssl-dev \
    libswscale-dev \
    libtool \
    libudev-dev \
    libusb-1.0-0-dev \
    libva-dev \
    libvdpau-dev \
    libvulkan-dev \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-render-util0 \
    libxcb-xinerama0 \
    libxcb-xkb1 \
    libxext-dev \
    libxkbcommon-x11-0 \
    libzstd-dev \
    mesa-common-dev \
    nasm \
    ninja-build \
    nlohmann-json3-dev \
    patch \
    pkg-config \
    qt6-base-private-dev \
    qt6-charts-dev \
    qt6-multimedia-dev \
    qt6-tools-dev \
    qt6-webengine-dev \
    spirv-headers \
    spirv-tools \
    spirv-tools-dev \
    vulkan-utility-libraries-dev \
    zlib1g-dev && \
  echo "**** build eden ****" && \
  mkdir -p /root-out/usr/bin && \
  mkdir -p /root-out/usr/share/icons/hicolor/scalable/apps/ && \
  EDEN_VERSION=$(curl -sX GET 'https://git.eden-emu.dev/api/v1/repos/eden-emu/eden/releases/latest' \
    | jq -er '.tag_name') && \
  cd /tmp && \
  git clone https://git.eden-emu.dev/eden-emu/eden.git && \
  cd eden/ && \
  echo "**** building eden at ${EDEN_VERSION} ****" && \
  git checkout -f ${EDEN_VERSION} && \
  cmake -B build -GNinja \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=None \
    -DCMAKE_C_FLAGS="-march=x86-64-v3 -O2" \
    -DCMAKE_CXX_FLAGS="-march=x86-64-v3 -O2" \
    -DUSE_DISCORD_PRESENCE=ON \
    -DYUZU_ENABLE_LTO=OFF \
    -DYUZU_USE_CPM=OFF \
    -DCPM_USE_LOCAL_PACKAGES=ON \
    -DYUZU_USE_BUNDLED_FFMPEG=OFF \
    -DYUZU_USE_BUNDLED_SDL2=OFF \
    -DYUZU_USE_EXTERNAL_SDL2=OFF \
    -DYUZU_USE_BUNDLED_QT=OFF \
    -DENABLE_QT_TRANSLATION=ON \
    -DYUZU_USE_QT_MULTIMEDIA=ON \
    -DYUZU_USE_QT_WEB_ENGINE=ON \
    -Dhttplib_FORCE_BUNDLED=ON \
    -DTITLE_BAR_FORMAT_RUNNING="eden | ${EDEN_VERSION} {}" \
    -DTITLE_BAR_FORMAT_IDLE="eden ${EDEN_VERSION} {}" \
    -DYUZU_TESTS=OFF \
    -DDYNARMIC_TESTS=OFF \
    -DBUILD_TESTING=OFF \
    -Wno-dev && \
  cmake --build build && \
  mv \
    build/bin/* \
    /root-out/usr/bin/ && \
  mv \
    dist/icon_variations/base.svg \
    /root-out/usr/share/icons/hicolor/scalable/apps/dev.eden_emu.eden.svg

FROM ghcr.io/${REPO}:ubuntu-resolute AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libavcodec62 \
    libavfilter11 \
    libboost-context1.90.0 \
    libboost-fiber1.90.0 \
    libboost-filesystem1.90.0 \
    libcubeb0 \
    libenet7 \
    libfmt10 \
    libhidapi-hidraw0 \
    liblz4-1 \
    libopus0 \
    libqt6charts6 \
    libqt6core5compat6 \
    libqt6multimedia6 \
    libqt6svg6 \
    libqt6webenginewidgets6 \
    libquazip1-qt6-1t64 \
    libsdl2-2.0-0 \
    libsimpleini1t64 \
    libssl3t64 \
    libswscale9 \
    libusb-1.0-0 \
    libva2 \
    libvdpau1 \
    libxcb-cursor0 \
    libzstd1 \
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
  echo "**** create desktop file ****" && \
  DEST="/usr/share/applications/eden-pa.desktop" && \
  echo '[Desktop Entry]' > "${DEST}" && \
  echo 'Version=1.0' >> "${DEST}" && \
  echo 'Type=Application' >> "${DEST}" && \
  echo 'Name=Eden PA' >> "${DEST}" && \
  echo 'GenericName=Switch Emulator' >> "${DEST}" && \
  echo 'Comment=Multiplatform FOSS Switch 1 emulator written in C++, derived from Yuzu and Sudachi' >> "${DEST}" && \
  echo 'Icon=dev.eden_emu.eden' >> "${DEST}" && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':eden %U"' >> "${DEST}" && \
  echo 'Categories=Game;Emulator;Qt;' >> "${DEST}" && \
  echo 'MimeType=application/x-nx-nro;application/x-nx-nso;application/x-nx-nsp;application/x-nx-xci;' >> "${DEST}" && \
  echo 'Keywords=Nintendo;Switch;' >> "${DEST}" && \
  echo 'StartupWMClass=eden' >> "${DEST}" && \
  echo "**** set bin name ****" && \
  echo "eden-pa" > /bin-name

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
