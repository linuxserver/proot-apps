ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm-av as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    xz-utils && \
  ARCH=$(uname -m| sed 's/x86_64/amd64/g'| sed 's/aarch64/arm64/') && \
  VIVALDI_DEB=$(curl -sL https://repo.vivaldi.com/archive/deb/pool/main/ \
    | awk -F'(<a href="|">)' '/vivaldi-stable/ {print $2}' \
    | grep ${ARCH} \
    | tail -1) && \
  curl -o \
    /tmp/vivaldi.deb -L \
    "https://repo.vivaldi.com/archive/deb/pool/main/${VIVALDI_DEB}" && \
  apt install -y --no-install-recommends \
    /tmp/vivaldi.deb && \
  for i in {1..15};do /opt/vivaldi/update-ffmpeg || sleep 1;done && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:vivaldi %U\"" \
    -e "s/Name=Vivaldi/Name=Vivaldi PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/vivaldi-stable.desktop && \
  mv \
    /usr/share/applications/vivaldi-stable.desktop \
    /usr/share/applications/vivaldi-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "vivaldi-pa" > /bin-name && \
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
