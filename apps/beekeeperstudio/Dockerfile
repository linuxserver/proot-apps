ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm-av as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    openssh-client && \
  ARCH=$(uname -m| sed 's/x86_64/amd64/g'| sed 's/aarch64/arm64/') && \
  BEE_VERSION=$(curl -sX GET "https://api.github.com/repos/beekeeper-studio/beekeeper-studio/releases/latest" \
  | awk '/tag_name/{print $4;exit}' FS='[""]') && \
  curl -o \
    /tmp/bee.deb -L \
    "https://github.com/beekeeper-studio/beekeeper-studio/releases/download/${BEE_VERSION}/beekeeper-studio_$(echo $BEE_VERSION| sed 's/^v//g')_${ARCH}.deb" && \
  apt install -y --no-install-recommends \
    /tmp/bee.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:beekeeperstudio %U\"" \
    -e "s/Name=Beekeeper Studio/Name=Beekeeper Studio PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/beekeeper-studio.desktop && \
  mv \
    /usr/share/applications/beekeeper-studio.desktop \
    /usr/share/applications/beekeeperstudio-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "beekeeperstudio-pa" > /bin-name && \
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
