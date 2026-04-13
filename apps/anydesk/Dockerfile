ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    jq \
    libpolkit-gobject-1-0 && \
  DEB=$(curl -sL https://download.anydesk.com/linux/ \
  | awk -F '(">|<)' '/_amd64.deb/ && !/sum/ {print $3}' |tail -n1) && \
  curl -o \
    /tmp/anydesk.deb -L \
    "https://download.anydesk.com/linux/${DEB}" && \
  apt install -y --no-install-recommends \
    /tmp/anydesk.deb || : && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:anydesk %U\"" \
    -e "s/Name=AnyDesk/Name=AnyDesk PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/anydesk.desktop && \
  mv \
    /usr/share/applications/anydesk.desktop \
    /usr/share/applications/anydesk-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "anydesk-pa" > /bin-name && \
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
