ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    jq \
    libpolkit-gobject-1-0 && \
  URL=$(curl -sL https://anydesk.com/en/downloads/linux \
    |awk -F'(var downloads=|;)' '/Debian/ {print $2}' \
    | head -2 | jq -r '.linux.packages[]|select(.name|startswith("Debian")).url') && \
  curl -o \
    /tmp/anydesk.deb -L \
    "${URL}" && \
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
