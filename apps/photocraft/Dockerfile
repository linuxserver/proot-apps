ARG REPO
FROM ghcr.io/${REPO}:ubuntu-resolute AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libegl1 \
    xdg-desktop-portal && \
  PHOTOCRAFT_VERSION=$(curl -sX GET "https://api.github.com/repos/storytold/photocraft/releases/latest" \
    | jq -r '.tag_name') && \
  curl -o \
    /tmp/photocraft.deb -L \
    "https://github.com/storytold/photocraft/releases/download/${PHOTOCRAFT_VERSION}/photocraft-$(echo ${PHOTOCRAFT_VERSION}| sed 's/^v//g')-linux-$(uname -m).deb" && \
  apt-get install -y --no-install-recommends \
    /tmp/photocraft.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:photocraft %U\"" \
    -e "s/^Name=PhotoCraft$/Name=PhotoCraft PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/ai.storyteller.photocraft.desktop && \
  mv \
    /usr/share/applications/ai.storyteller.photocraft.desktop \
    /usr/share/applications/photocraft-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "photocraft-pa" > /bin-name && \
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
