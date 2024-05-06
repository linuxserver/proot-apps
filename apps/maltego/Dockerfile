ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    default-jre \
    jq && \
  DEB_URL=$(curl -sL https://downloads.maltego.com/maltego-v4/info.json \
    | jq -r '.[] | select(.os == "linux" and .["file-type"] == ".deb") | .url') && \
  curl -o \
    /tmp/maltego.deb -L \
    "${DEB_URL}" && \
  apt install -y --no-install-recommends \
    /tmp/maltego.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:maltego %U\"" \
    -e "s/Name=Maltego/Name=Maltego PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/maltego.desktop && \
  mv \
    /usr/share/applications/maltego.desktop \
    /usr/share/applications/maltego-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "maltego-pa" > /bin-name && \
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
