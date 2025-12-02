ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    wget && \
  DEB=$(curl -sL https://repository-origin.spotify.com/pool/non-free/s/spotify-client/ \
    | awk -F'(href="|">)' '/amd64.deb/ {print $2}' \
    | tail -1) && \
  wget -O \
    /tmp/spotify.deb \
    "https://repository-origin.spotify.com/pool/non-free/s/spotify-client/${DEB}" && \
  apt install -y --no-install-recommends \
    /tmp/spotify.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:spotify %U\"" \
    -e "s/Name=Spotify/Name=Spotify PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/spotify/spotify.desktop && \
  mv \
    /usr/share/spotify/spotify.desktop \
    /usr/share/spotify/spotify-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "spotify-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  apt-get remove -y \
    wget && \
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
