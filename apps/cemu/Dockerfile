ARG REPO
FROM ghcr.io/${REPO}:ubuntu-resolute AS build

# Build cemu
RUN \
  echo "**** install build deps ****" && \
  apt-get update && \
  apt-get install -y \
    build-essential \
    cmake \
    freeglut3-dev \
    git \
    libbluetooth-dev \
    libboost-dev \
    libboost-filesystem-dev \
    libboost-nowide-dev \
    libboost-program-options-dev \
    libcubeb-dev \
    libcurl4-openssl-dev \
    libglm-dev \
    libfmt-dev \
    libgtk-3-dev \
    libhidapi-dev \
    libpng-dev \
    libpugixml-dev \
    libpulse-dev \
    libsdl2-dev \
    libssl-dev \
    libusb-1.0-0-dev \
    libwayland-dev \
    libwxgtk3.2-dev \
    libx11-dev \
    libzip-dev \
    libzstd-dev \
    nasm \
    ninja-build \
    pkg-config \
    python3 \
    rapidjson-dev \
    wayland-protocols \
    zlib1g-dev && \
  echo "**** build cemu ****" && \
  CEMU_VERSION=$(curl -sX GET "https://api.github.com/repos/cemu-project/Cemu/releases/latest" \
    | jq -er '.tag_name') && \
  mkdir -p /root-out/usr/bin && \
  mkdir -p /root-out/usr/share/Cemu && \
  mkdir -p /root-out/usr/share/icons/hicolor/scalable/apps && \
  cd /tmp && \
  git clone https://github.com/KhronosGroup/glslang.git && \
  cd glslang && \
  git checkout -f 14.2.0 && \
  ./update_glslang_sources.py && \
  cmake -S . -B build \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_FLAGS="-include cstdint" \
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
    -G Ninja && \
  cmake --build build && \
  cmake --install build && \
  cd /tmp && \
  git clone https://github.com/cemu-project/Cemu.git && \
  cd Cemu && \
  echo "**** building cemu at ${CEMU_VERSION} ****" && \
  git checkout -f ${CEMU_VERSION} && \
  git submodule update --init --recursive \
    dependencies/cubeb \
    dependencies/ih264d \
    dependencies/imgui \
    dependencies/Vulkan-Headers \
    dependencies/ZArchive && \
  mkdir -p /usr/lib/x86_64-linux-gnu/cmake/hidapi && \
  printf '%s\n' \
    'add_library(hidapi::hidapi SHARED IMPORTED)' \
    'set_target_properties(hidapi::hidapi PROPERTIES' \
    '  IMPORTED_LOCATION "/usr/lib/x86_64-linux-gnu/libhidapi-hidraw.so"' \
    '  INTERFACE_INCLUDE_DIRECTORIES "/usr/include/hidapi")' \
    > /usr/lib/x86_64-linux-gnu/cmake/hidapi/hidapiConfig.cmake && \
  sed -i \
    's/set(CMAKE_INTERPROCEDURAL_OPTIMIZATION_RELEASE ON)/set(CMAKE_INTERPROCEDURAL_OPTIMIZATION_RELEASE OFF)/' \
    CMakeLists.txt && \
  cmake -S . -B build \
    -DCMAKE_BUILD_TYPE=release \
    -DCMAKE_C_COMPILER=/usr/bin/gcc \
    -DCMAKE_CXX_COMPILER=/usr/bin/g++ \
    -DCMAKE_MAKE_PROGRAM=/usr/bin/ninja \
    -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
    -DENABLE_DISCORD_RPC=OFF \
    -DENABLE_FERAL_GAMEMODE=OFF \
    -DENABLE_VCPKG=OFF \
    -G Ninja && \
  cmake --build build && \
  cp -r \
    bin/* \
    /root-out/usr/share/Cemu/ && \
  mv \
    /root-out/usr/share/Cemu/Cemu_release \
    /root-out/usr/bin/Cemu && \
  cp \
    dist/linux/info.cemu.Cemu.png \
    /root-out/usr/share/icons/hicolor/scalable/apps/info.cemu.Cemu.png

FROM ghcr.io/${REPO}:ubuntu-resolute AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libbluetooth3 \
    libboost-filesystem1.90.0 \
    libboost-nowide1.90.0 \
    libboost-program-options1.90.0 \
    libcubeb0 \
    libcurl4t64 \
    libgtk-3-0t64 \
    libgtk-3-common \
    libhidapi-hidraw0 \
    libopengl0 \
    libpng16-16t64 \
    libpugixml1v5 \
    libsdl2-2.0-0 \
    libssl3t64 \
    libusb-1.0-0 \
    libwxgtk-gl3.2-1t64 \
    libwxgtk3.2-1t64 \
    libzip5 \
    libzstd1 && \
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
  DEST="/usr/share/applications/cemu-pa.desktop" && \
  echo '[Desktop Entry]' > "${DEST}" && \
  echo 'Version=1.0' >> "${DEST}" && \
  echo 'Name=Cemu PA' >> "${DEST}" && \
  echo 'GenericName=Wii U Emulator' >> "${DEST}" && \
  echo 'Comment=Software to emulate Wii U games and applications on PC' >> "${DEST}" && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':cemu %U"' >> "${DEST}" && \
  echo 'Icon=info.cemu.Cemu' >> "${DEST}" && \
  echo 'Terminal=false' >> "${DEST}" && \
  echo 'Type=Application' >> "${DEST}" && \
  echo 'Categories=Game;Emulator;' >> "${DEST}" && \
  echo 'MimeType=application/x-wii-u-rom;' >> "${DEST}" && \
  echo 'Keywords=Nintendo;' >> "${DEST}" && \
  echo "**** set bin name ****" && \
  echo "cemu-pa" > /bin-name

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
