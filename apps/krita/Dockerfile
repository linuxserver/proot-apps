ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libgpg-error0 && \
  echo "**** install krita ****" && \
  DOWNLOAD_URL=$(curl -sL https://download.kde.org/stable/krita/updates/Krita-Stable-x86_64.appimage.zsync \
    | awk '/URL: https/ {print $2}') && \
  curl -o \
    /tmp/krita.app -L \
    "${DOWNLOAD_URL}" && \
  cd /tmp && \
  chmod +x krita.app && \
  ./krita.app --appimage-extract && \
  mv \
    squashfs-root \
    /opt/krita && \
  ln -s \
    /opt/krita/AppRun \
    /usr/bin/krita && \
  echo "**** customize desktop file ****" && \
  mkdir -p \
    /usr/share/icons/hicolor/256x256/apps && \
  cp \
    /opt/krita/krita.png \
    /usr/share/icons/hicolor/256x256/apps/krita.png && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:krita %U\"" \
    -e "s/Name=Krita/Name=Krita PA/g" \
    -e '/^TryExec=/d' \
    /opt/krita/org.kde.krita.desktop && \
  mv \
    /opt/krita/org.kde.krita.desktop \
    /usr/share/applications/krita-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "krita-pa" > /bin-name && \
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
