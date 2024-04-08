ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm-av as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  curl -o \
    /tmp/chrome.deb -L \
    "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" && \
  apt install -y --no-install-recommends \
    /tmp/chrome.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:chrome %U\"" \
    -e "s/Name=Google Chrome/Name=Chrome PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/google-chrome.desktop && \
  mv \
    /usr/share/applications/google-chrome.desktop \
    /usr/share/applications/chrome-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "chrome-pa" > /bin-name && \
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
