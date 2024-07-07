ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    jq \
    libasound2 \
    libatk1.0-0 \
    libatk-bridge2.0 \
    libcups2 \
    libdrm2 \
    libgbm1 \
    libgtk-3-0 && \
  URL=$(curl -sX GET "https://api.github.com/repos/bitwarden/clients/releases" \
    | jq -r '[.[]| select(.tag_name|startswith("desktop"))][0].assets| .[] |select(.name|endswith("deb")).browser_download_url') && \
  curl -o \
    /tmp/bitwarden.deb -L \
    "${URL}" && \
  apt install -y --no-install-recommends \
    /tmp/bitwarden.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:bitwarden %U\"" \
    -e "s/Name=Bitwarden/Name=Bitwarden PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/bitwarden.desktop && \
  mv \
    /usr/share/applications/bitwarden.desktop \
    /usr/share/applications/bitwarden-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "bitwarden-pa" > /bin-name && \
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
