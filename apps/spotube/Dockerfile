ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  SPOTUBE_VERSION=$(curl -sX GET "https://api.github.com/repos/KRTirtho/spotube/releases/latest" \
  | awk '/tag_name/{print $4;exit}' FS='[""]') && \
  curl -o \
    /tmp/spotube.deb -L \
    "https://github.com/KRTirtho/spotube/releases/download/${SPOTUBE_VERSION}/Spotube-linux-x86_64.deb" && \
  apt install -y --no-install-recommends \
    /tmp/spotube.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:spotube %U\"" \
    -e "s/Name=Spotube/Name=Spotube PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/spotube.desktop && \
  mv \
    /usr/share/applications/spotube.desktop \
    /usr/share/applications/spotube-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "spotube-pa" > /bin-name && \
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
