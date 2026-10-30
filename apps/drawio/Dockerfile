ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  DRAWIO_VERSION=$(curl -sX GET "https://api.github.com/repos/jgraph/drawio-desktop/releases/latest" \
    | jq -r '.tag_name') && \
  curl -o \
    /tmp/drawio.deb -L \
    "https://github.com/jgraph/drawio-desktop/releases/download/${DRAWIO_VERSION}/drawio-amd64-$(echo ${DRAWIO_VERSION}| sed 's/^v//g').deb" && \
  apt-get install -y --no-install-recommends \
    /tmp/drawio.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:drawio %U\"" \
    -e "s/^Name=drawio$/Name=draw.io PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/drawio.desktop && \
  mv \
    /usr/share/applications/drawio.desktop \
    /usr/share/applications/drawio-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "drawio-pa" > /bin-name && \
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
