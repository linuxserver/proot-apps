ARG REPO
FROM ghcr.io/${REPO}:ubuntu-resolute AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libegl1 \
    libwayland-client0 \
    libx11-6 \
    libx11-xcb1 \
    libxcursor1 \
    libxi6 \
    libxkbcommon-x11-0 \
    libxrandr2 \
    xdg-desktop-portal && \
  VECTORCRAFT_VERSION=$(curl -sX GET "https://api.github.com/repos/storytold/vectorcraft/releases/latest" \
    | jq -r '.tag_name') && \
  curl -o \
    /tmp/vectorcraft.deb -L \
    "https://github.com/storytold/vectorcraft/releases/download/${VECTORCRAFT_VERSION}/vectorcraft-$(echo ${VECTORCRAFT_VERSION}| sed 's/^v//g')-linux-$(uname -m).deb" && \
  apt-get install -y --no-install-recommends \
    /tmp/vectorcraft.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:vectorcraft %U\"" \
    -e "s/^Name=VectorCraft$/Name=VectorCraft PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/ai.storyteller.vectorcraft.desktop && \
  mv \
    /usr/share/applications/ai.storyteller.vectorcraft.desktop \
    /usr/share/applications/vectorcraft-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "vectorcraft-pa" > /bin-name && \
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
