ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  BRUNO_VERSION=$(curl -sX GET "https://api.github.com/repos/usebruno/bruno/releases/latest" \
    | jq -r '.tag_name') && \
  curl -o \
    /tmp/bruno.deb -L \
    "https://github.com/usebruno/bruno/releases/download/${BRUNO_VERSION}/bruno_$(echo ${BRUNO_VERSION}| sed 's/^v//g')_amd64_linux.deb" && \
  apt-get install -y --no-install-recommends \
    /tmp/bruno.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:bruno %U\"" \
    -e "s/^Name=Bruno$/Name=Bruno PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/bruno.desktop && \
  mv \
    /usr/share/applications/bruno.desktop \
    /usr/share/applications/bruno-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "bruno-pa" > /bin-name && \
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
