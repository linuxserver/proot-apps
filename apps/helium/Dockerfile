ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  ARCH=$(uname -m| sed 's/x86_64/amd64/g'| sed 's/aarch64/arm64/') && \
  HELIUM_VERSION=$(curl -sX GET "https://api.github.com/repos/imputnet/helium-linux/releases/latest"\
    | awk '/tag_name/{print $4;exit}' FS='[""]') && \
  curl -o \
    /tmp/helium.deb -L \
    "https://github.com/imputnet/helium-linux/releases/download/${HELIUM_VERSION}/helium-bin_${HELIUM_VERSION}-1_${ARCH}.deb" && \
  apt install -y \
    /tmp/helium.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:helium %U\"" \
    -e "s/Name=Helium/Name=Helium PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/helium.desktop && \
  mv \
    /usr/share/applications/helium.desktop \
    /usr/share/applications/helium-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "helium-pa" > /bin-name && \
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
