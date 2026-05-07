ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  curl -fsSLo \
    /usr/share/keyrings/brave-browser-nightly-archive-keyring.gpg \
    https://brave-browser-apt-nightly.s3.brave.com/brave-browser-nightly-archive-keyring.gpg && \
  curl -fsSLo \
    /etc/apt/sources.list.d/brave-browser-nightly.sources \
    https://brave-browser-apt-nightly.s3.brave.com/brave-browser.sources && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    brave-origin-nightly && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:braveorigin %U\"" \
    -e "s/Name=Brave Origin (nightly)/Name=Brave Origin PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/brave-origin-nightly.desktop && \
  mv \
    /usr/share/applications/brave-origin-nightly.desktop \
    /usr/share/applications/brave-origin-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "braveorigin-pa" > /bin-name && \
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
