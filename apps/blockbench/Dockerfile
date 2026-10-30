ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS rootfs
ARG REPO

# Add local files
COPY /root /

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  BLOCKBENCH_VERSION=$(curl -sX GET "https://api.github.com/repos/JannisX11/blockbench/releases/latest" \
    | jq -r '.tag_name') && \
  curl -o \
    /tmp/blockbench.deb -L \
    "https://github.com/JannisX11/blockbench/releases/download/${BLOCKBENCH_VERSION}/Blockbench_$(echo ${BLOCKBENCH_VERSION}| sed 's/^v//g').deb" && \
  apt-get install -y --no-install-recommends \
    /tmp/blockbench.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:blockbench %U\"" \
    -e "s/^Name=Blockbench$/Name=Blockbench PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/net.blockbench.blockbench.desktop && \
  mv \
    /usr/share/applications/net.blockbench.blockbench.desktop \
    /usr/share/applications/blockbench-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "blockbench-pa" > /bin-name && \
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
