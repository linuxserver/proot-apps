ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    fonts-noto-color-emoji && \
  ARCH=$(uname -m| sed 's/x86_64/amd64/g'| sed 's/aarch64/arm64/') && \
  FERDIUM_VERSION=$(curl -sX GET "https://api.github.com/repos/ferdium/ferdium-app/releases/latest" \
    | awk '/tag_name/{print $4;exit}' FS='[""]') && \
  curl -o \
    /tmp/ferdium.deb -L \
    "https://github.com/ferdium/ferdium-app/releases/download/${FERDIUM_VERSION}/Ferdium-linux-$(echo $FERDIUM_VERSION | sed 's/^v//g')-${ARCH}.deb" && \
  apt install -y --no-install-recommends \
    /tmp/ferdium.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:ferdium %U\"" \
    -e "s/Name=Ferdium/Name=Ferdium PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/ferdium.desktop && \
  mv \
    /usr/share/applications/ferdium.desktop \
    /usr/share/applications/ferdium-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "ferdium-pa" > /bin-name && \
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
