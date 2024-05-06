ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  curl -o \
    /tmp/edge.deb -L \
    "https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/$(curl -sLq https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/ | awk -F'(<a href="|")' '/href=/ {print $2}' | sort --version-sort | tail -1)" && \
  apt install -y --no-install-recommends \
    /tmp/edge.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:edge %U\"" \
    -e "s/Name=Microsoft Edge/Name=Edge PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/microsoft-edge.desktop && \
  mv \
    /usr/share/applications/microsoft-edge.desktop \
    /usr/share/applications/edge-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "edge-pa" > /bin-name && \
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
