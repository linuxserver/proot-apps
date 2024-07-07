ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    jq && \
  ARCH=$(uname -m| sed 's/x86_64/amd64/g'| sed 's/aarch64/arm64/') && \
  FREETUBE_RELEASE=$(curl -sL "https://api.github.com/repos/FreeTubeApp/FreeTube/releases" \
    | jq -r 'map(select(.prerelease)) | first | .id') && \
  URL=$(curl -sL "https://api.github.com/repos/FreeTubeApp/FreeTube/releases/${FREETUBE_RELEASE}" \
    |jq -r '.assets[]|select(.name|endswith("'${ARCH}'.deb")).browser_download_url') && \
  curl -o \
    /tmp/freetube.deb -L \
    "${URL}" && \
  apt install -y --no-install-recommends \
    /tmp/freetube.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:freetube %U\"" \
    -e "s/Name=FreeTube/Name=FreeTube PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/freetube.desktop && \
  mv \
    /usr/share/applications/freetube.desktop \
    /usr/share/applications/freetube-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "freetube-pa" > /bin-name && \
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
