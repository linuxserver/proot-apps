ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libasound2t64 \
    libgtk-3-0t64 \
    libpulse0 \
    libx11-xcb1 \
    xz-utils && \
  FLOORP_VERSION=$(curl -sX GET "https://api.github.com/repos/Floorp-Projects/Floorp/releases/latest" \
    | jq -r '.tag_name') && \
  curl -o \
    /tmp/floorp.tar.xz -L \
    "https://github.com/Floorp-Projects/Floorp/releases/download/${FLOORP_VERSION}/floorp-linux-x86_64.tar.xz" && \
  mkdir -p /opt/floorp && \
  tar xf \
    /tmp/floorp.tar.xz -C \
    /opt/floorp/ --strip-components=1 && \
  echo "**** customize desktop file ****" && \
  DESKTOP_FILE=/usr/share/applications/floorp-pa.desktop && \
  echo '[Desktop Entry]' > ${DESKTOP_FILE} && \
  echo 'Type=Application' >> ${DESKTOP_FILE} && \
  echo 'Name=Floorp PA' >> ${DESKTOP_FILE} && \
  echo 'GenericName=Web Browser' >> ${DESKTOP_FILE} && \
  echo 'Icon=floorp' >> ${DESKTOP_FILE} && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':floorp %U"' >> ${DESKTOP_FILE} && \
  echo 'Categories=Network;WebBrowser;' >> ${DESKTOP_FILE} && \
  echo "**** set bin name ****" && \
  echo "floorp-pa" > /bin-name && \
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
