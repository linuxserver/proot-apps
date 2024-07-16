ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    hicolor-icon-theme \
    libnss3 \
    libxcb-cursor0 \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-render-util0 \
    libxcb-shape0 \
    libxcb-xkb1 \
    libxcomposite1 \
    libxdamage1 \
    libxi6 \
    libxkbcommon-x11-0 \
    locales \
    mpv \
    zstd && \
  ANKI_VERSION=$(curl -sX GET "https://api.github.com/repos/ankitects/anki/releases/latest" \
  | awk '/tag_name/{print $4;exit}' FS='[""]') && \
  mkdir -p \
    /usr/share/desktop-directories \
    /tmp/anki && \
  curl -o \
    /tmp/anki.tar.zst -L \
    "https://github.com/ankitects/anki/releases/download/${ANKI_VERSION}/anki-${ANKI_VERSION}-linux-qt6.tar.zst" && \
  tar -xf \
    /tmp/anki.tar.zst -C \
    /tmp/anki --strip-components=1 && \
  cd /tmp/anki && \
  ./install.sh && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:anki %U\"" \
    -e "s/Name=Anki/Name=Anki PA/g" \
    -e '/^TryExec=/d' \
    /usr/local/share/applications/anki.desktop && \
  mv \
    /usr/local/share/applications/anki.desktop \
    /usr/share/applications/anki-pa.desktop && \
  localedef -i en_US -f UTF-8 en_US.UTF-8 && \
  echo "**** set bin name ****" && \
  echo "anki-pa" > /bin-name && \
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
