ARG REPO
FROM ghcr.io/${REPO}:ubuntu-resolute AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** add ppsspp repo ****" && \
  mkdir -p /etc/apt/keyrings && \
  curl -o \
    /etc/apt/keyrings/ppsspp.asc -L \
    "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x621ECF9C18E50D47695A67E701E1284726FFA4A2" && \
  echo \
    "deb [signed-by=/etc/apt/keyrings/ppsspp.asc] https://ppa.launchpadcontent.net/xuzhen666/ppsspp/ubuntu resolute main" > \
    /etc/apt/sources.list.d/ppsspp.list && \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    ppsspp && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:ppsspp %U\"" \
    -e "s/^Name=.*/Name=PPSSPP PA/" \
    -e '/^TryExec=/d' \
    /usr/share/applications/ppsspp.desktop && \
  mv \
    /usr/share/applications/ppsspp.desktop \
    /usr/share/applications/ppsspp-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "ppsspp-pa" > /bin-name && \
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
