ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    gsettings-desktop-schemas && \
  OPERA_VERSION=$(curl -sL https://deb.opera.com/opera-stable/dists/stable/non-free/binary-amd64/Packages \
    | awk -F ': ' '/opera-stable/{ getline; print $2; exit}') && \
  curl -o \
    /tmp/opera.deb -L \
    "https://deb.opera.com/opera-stable/pool/non-free/o/opera-stable/opera-stable_${OPERA_VERSION}_amd64.deb" && \
  DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends \
    /tmp/opera.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:opera %U\"" \
    -e "s/Name=Opera/Name=Opera PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/opera.desktop && \
  mv \
    /usr/share/applications/opera.desktop \
    /usr/share/applications/opera-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "opera-pa" > /bin-name && \
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
