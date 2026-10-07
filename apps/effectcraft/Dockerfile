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
  EFFECTCRAFT_VERSION=$(curl -sX GET "https://api.github.com/repos/storytold/effectcraft/releases/latest" \
    | jq -r '.tag_name') && \
  curl -o \
    /tmp/effectcraft.deb -L \
    "https://github.com/storytold/effectcraft/releases/download/${EFFECTCRAFT_VERSION}/effectcraft-$(echo ${EFFECTCRAFT_VERSION}| sed 's/^v//g')-linux-$(uname -m).deb" && \
  apt-get install -y --no-install-recommends \
    /tmp/effectcraft.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:effectcraft %U\"" \
    -e "s/^Name=EffectCraft$/Name=EffectCraft PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/ai.storyteller.effectcraft.desktop && \
  mv \
    /usr/share/applications/ai.storyteller.effectcraft.desktop \
    /usr/share/applications/effectcraft-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "effectcraft-pa" > /bin-name && \
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
