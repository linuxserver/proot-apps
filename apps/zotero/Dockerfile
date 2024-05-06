ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    lbzip2 \
    libdbus-glib-1-2 \
    libgtk-3-0 && \
  ZOTERO_VERSION=$(curl -sL https://www.zotero.org/download/ \
    |awk -F'linux-x86_64' '/linux-x86_64/ {print $2}' \
    | awk -F'"' '{print $3}') && \
  curl -o \
    /tmp/zotero.tar.bz2  -L \
    "https://download.zotero.org/client/release/${ZOTERO_VERSION}/Zotero-${ZOTERO_VERSION}_linux-x86_64.tar.bz2" && \
  mkdir /opt/zotero && \
  tar xf \
    /tmp/zotero.tar.bz2 -C \
    /opt/zotero/ --strip-components=1 && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:zotero %U\"" \
    -e "s/Name=Zotero/Name=Zotero PA/g" \
    -e 's:Icon=zotero.ico:Icon=zotero:g' \
    -e '/^TryExec=/d' \
    /opt/zotero/zotero.desktop && \
  mv \
    /opt/zotero/zotero.desktop \
    /usr/share/applications/zotero-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "zotero-pa" > /bin-name && \
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
