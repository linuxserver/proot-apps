ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  YOUTUBEMUSIC_VERSION=$(curl -sX GET "https://api.github.com/repos/pear-devs/pear-desktop/releases/latest" \
    | jq -r '.tag_name') && \
  curl -o \
    /tmp/youtubemusic.deb -L \
    "https://github.com/pear-devs/pear-desktop/releases/download/${YOUTUBEMUSIC_VERSION}/youtube-music_$(echo ${YOUTUBEMUSIC_VERSION}| sed 's/^v//g')_amd64.deb" && \
  apt-get install -y --no-install-recommends \
    /tmp/youtubemusic.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:youtubemusic %U\"" \
    -e "s/^Name=YouTube Music$/Name=YouTube Music PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/com.github.th-ch.youtube-music.desktop && \
  mv \
    /usr/share/applications/com.github.th-ch.youtube-music.desktop \
    /usr/share/applications/youtubemusic-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "youtubemusic-pa" > /bin-name && \
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
