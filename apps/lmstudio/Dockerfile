ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libasound2t64 \
    libatk1.0-0t64 \
    libatk-bridge2.0-0t64 \
    libgtk-3-0t64 \
    libnss3 \
    python3-xdg && \
  curl -o \
    /tmp/lm.app -L \
    "https://lmstudio.ai/download/latest/linux/x64?format=AppImage" && \
  chmod +x /tmp/lm.app && \
  cd /tmp && \
  ./lm.app --appimage-extract && \
  mv squashfs-root /opt/lm-studio && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:lmstudio %U\"" \
    -e "s/^Name=LM-Studio$/Name=LM Studio PA/g" \
    -e '/^X-AppImage-Version=/d' \
    -e '/^category=/d' \
    -e '/^TryExec=/d' \
    /opt/lm-studio/ai.elementlabs.lmstudio.desktop && \
  mv \
    /opt/lm-studio/ai.elementlabs.lmstudio.desktop \
    /usr/share/applications/lmstudio-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "lmstudio-pa" > /bin-name && \
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
