ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libgtk-3-0t64 \
    libjavascriptcoregtk-4.1-0 \
    libwebkit2gtk-4.1-0 && \
  YAAK_VERSION=$(curl -sX GET "https://api.github.com/repos/mountain-loop/yaak/releases/latest" \
    | jq -r '.tag_name') && \
  curl -o \
    /tmp/yaak.deb -L \
    "https://github.com/mountain-loop/yaak/releases/download/${YAAK_VERSION}/yaak_$(echo ${YAAK_VERSION}| sed 's/^v//g')_amd64.deb" && \
  apt-get install -y --no-install-recommends \
    /tmp/yaak.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:yaak\"" \
    -e "s/^Name=yaak$/Name=Yaak PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/yaak.desktop && \
  mv \
    /usr/share/applications/yaak.desktop \
    /usr/share/applications/yaak-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "yaak-pa" > /bin-name && \
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
