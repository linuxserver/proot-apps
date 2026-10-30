ARG REPO
FROM ghcr.io/${REPO}:ubuntu-resolute AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libappindicator3-1 \
    libgtk-3-0t64 \
    libjavascriptcoregtk-4.1-0 \
    libssl3t64 \
    libvulkan1 \
    libwayland-client0 \
    libwebkit2gtk-4.1-0 \
    mesa-vulkan-drivers && \
  JAN_VERSION=$(curl -sX GET "https://api.github.com/repos/janhq/jan/releases/latest" \
    | jq -r '.tag_name') && \
  curl -o \
    /tmp/jan.deb -L \
    "https://github.com/janhq/jan/releases/download/${JAN_VERSION}/Jan_$(echo ${JAN_VERSION}| sed 's/^v//g')_amd64.deb" && \
  apt-get install -y --no-install-recommends \
    /tmp/jan.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:jan\"" \
    -e "s/^Name=Jan$/Name=Jan PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/Jan.desktop && \
  mv \
    /usr/share/applications/Jan.desktop \
    /usr/share/applications/jan-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "jan-pa" > /bin-name && \
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
