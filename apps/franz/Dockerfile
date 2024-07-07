ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  FRANZ_VERSION=$(curl -sX GET "https://api.github.com/repos/meetfranz/franz/releases/latest" \
  | awk '/tag_name/{print $4;exit}' FS='[""]') && \
  curl -o \
    /tmp/franz.deb -L \
    "https://github.com/meetfranz/franz/releases/download/${FRANZ_VERSION}/franz_$(echo $FRANZ_VERSION|sed 's/^v//g')_amd64.deb" && \
  apt install -y --no-install-recommends \
    /tmp/franz.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:franz %U\"" \
    -e "s/Name=Franz/Name=Franz PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/franz.desktop && \
  mv \
    /usr/share/applications/franz.desktop \
    /usr/share/applications/franz-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "franz-pa" > /bin-name && \
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
