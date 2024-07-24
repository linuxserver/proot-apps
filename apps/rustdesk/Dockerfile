ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  RD_VERSION=$(curl -sX GET "https://api.github.com/repos/rustdesk/rustdesk/releases/latest" \
  | awk '/tag_name/{print $4;exit}' FS='[""]') && \
  curl -o \
    /tmp/rustdesk.deb -L \
    "https://github.com/rustdesk/rustdesk/releases/download/${RD_VERSION}/rustdesk-${RD_VERSION}-$(uname -m).deb" && \
  apt install -y --no-install-recommends \
    /tmp/rustdesk.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:rustdesk %U\"" \
    -e "s/Name=RustDesk/Name=RustDesk PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/rustdesk.desktop && \
  mv \
    /usr/share/applications/rustdesk.desktop \
    /usr/share/applications/rustdesk-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "rustdesk-pa" > /bin-name && \
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
