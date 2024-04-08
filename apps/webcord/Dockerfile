ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm-av as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    fonts-noto-color-emoji && \
  ARCH=$(uname -m| sed 's/x86_64/amd64/g'| sed 's/aarch64/arm64/') && \
  WEBCORD_VERSION=$(curl -sX GET "https://api.github.com/repos/SpacingBat3/WebCord/releases/latest" \
    | awk '/tag_name/{print $4;exit}' FS='[""]') && \
  curl -o \
    /tmp/webcord.deb -L \
    "https://github.com/SpacingBat3/WebCord/releases/download/${WEBCORD_VERSION}/webcord_$(echo ${WEBCORD_VERSION}| cut -c2-)_${ARCH}.deb" && \
  apt install -y --no-install-recommends \
    /tmp/webcord.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:webcord %U\"" \
    -e "s/Name=WebCord/Name=WebCord PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/webcord.desktop && \
  mv \
    /usr/share/applications/webcord.desktop \
    /usr/share/applications/webcord-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "webcord-pa" > /bin-name && \
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
