ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libopengl0 \
    libxi6 \
    libxkbcommon0 \
    ocl-icd-libopencl1 \
    xz-utils && \
  ln -s libOpenCL.so.1 /usr/lib/x86_64-linux-gnu/libOpenCL.so && \
  echo "**** install blender ****" && \
  mkdir -p /opt/blender && \
  BLENDER_VERSION=$(curl -s https://projects.blender.org/api/v1/repos/blender/blender/tags \
    | jq -r '.[] | select(.name | contains("-rc") | not) | .name' \
    | sed 's|^v||g' | sort -rV | head -1) && \
  BLENDER_FOLDER=$(echo "Blender${BLENDER_VERSION}" | sed -r 's|(Blender[0-9]*\.[0-9]*)\.[0-9]*|\1|') && \
  curl -o \
    /tmp/blender.tar.xz -fL \
    "https://mirror.clarkson.edu/blender/release/${BLENDER_FOLDER}/blender-${BLENDER_VERSION}-linux-x64.tar.xz" || \
    curl -o \
      /tmp/blender.tar.xz -fL \
      "https://mirrors.iu13.net/blender/release/${BLENDER_FOLDER}/blender-${BLENDER_VERSION}-linux-x64.tar.xz" && \
  tar xf \
    /tmp/blender.tar.xz -C \
    /opt/blender/ --strip-components=1 && \
  ln -s \
    /opt/blender/blender \
    /usr/bin/blender && \
  echo "**** customize desktop file ****" && \
  mkdir -p \
    /usr/share/icons/hicolor/scalable/apps && \
  cp \
    /opt/blender/blender.svg \
    /usr/share/icons/hicolor/scalable/apps/blender.svg && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:blender %U\"" \
    -e "s/Name=Blender/Name=Blender PA/g" \
    -e '/^TryExec=/d' \
    /opt/blender/blender.desktop && \
  mv \
    /opt/blender/blender.desktop \
    /usr/share/applications/blender-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "blender-pa" > /bin-name && \
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
