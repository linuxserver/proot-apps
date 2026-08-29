ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS resynth

# Build resynthesizer plugin
RUN \
  echo "**** install build deps ****" && \
  apt-get update && \
  apt-get install -y \
    build-essential \
    libgimp-3.0-dev \
    meson && \
  echo "**** ingest and build resynthesizer ****" && \
  mkdir /buildout && \
  RESYNTH_RELEASE=$(curl -sX GET "https://api.github.com/repos/bootchk/resynthesizer/releases/latest" \
    | jq -r '.tag_name') && \
  curl -o \
    /tmp/resynth.tar.gz -L \
    "https://github.com/bootchk/resynthesizer/archive/refs/tags/${RESYNTH_RELEASE}.tar.gz" && \
  cd /tmp && \
  tar -xf resynth.tar.gz && \
  cd resynthesizer-* && \
  meson setup resynthesizerBuild -Dinstall-translations=false && \
  cd resynthesizerBuild && \
  meson compile --verbose -j $(nproc) && \
  DESTDIR=/buildout meson install && \
  mv /buildout/usr/local/lib /buildout/usr && \
  rm -Rf /buildout/usr/local

FROM ghcr.io/${REPO}:debian-trixie AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y \
    gimp \
    libgimp-3.0 && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:gimp %U\"" \
    -e "s/Name=GNU Image Manipulation Program/Name=GIMP PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/gimp.desktop && \
  mv \
    /usr/share/applications/gimp.desktop \
    /usr/share/applications/gimp-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "gimp-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  apt-get autoclean && \
  rm -rf \
    /root/.cache \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*

COPY --from=resynth /buildout /
COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
