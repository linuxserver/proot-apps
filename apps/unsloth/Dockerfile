ARG REPO
FROM ghcr.io/${REPO}:ubuntu-resolute AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    git \
    pciutils && \
  curl -o \
    /tmp/unsloth.deb -L \
    "https://github.com/unslothai/unsloth/releases/latest/download/Unsloth-Desktop-Ubuntu.deb" && \
  apt install -y --no-install-recommends \
    /tmp/unsloth.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:unsloth %U\"" \
    -e "s/^Name=Unsloth$/Name=Unsloth PA/g" \
    -e 's/^Categories=$/Categories=Development;Science;/' \
    -e '/^TryExec=/d' \
    /usr/share/applications/Unsloth.desktop && \
  mv \
    /usr/share/applications/Unsloth.desktop \
    /usr/share/applications/unsloth-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "unsloth-pa" > /bin-name && \
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
