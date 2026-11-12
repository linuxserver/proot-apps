ARG REPO
FROM ghcr.io/${REPO}:ubuntu-resolute AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** add RustConn OBS key ****" && \
  install -m 0755 -d /etc/apt/keyrings && \
  curl -fsSL \
    https://download.opensuse.org/repositories/home:/totoshko88:/rustconn/xUbuntu_26.04/Release.key \
    -o /etc/apt/keyrings/rustconn.asc && \
  chmod a+r /etc/apt/keyrings/rustconn.asc && \
  echo "**** add RustConn OBS repository ****" && \
  echo "deb [signed-by=/etc/apt/keyrings/rustconn.asc] https://download.opensuse.org/repositories/home:/totoshko88:/rustconn/xUbuntu_26.04/ /" \
    > /etc/apt/sources.list.d/rustconn.list && \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    freerdp3-sdl \
    freerdp3-x11 \
    libopenh264-8 \
    librsvg2-common \
    picocom \
    rustconn \
    tigervnc-viewer \
    virt-viewer && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:rustconn %f\"" \
    -e "s/^Name=RustConn$/Name=RustConn PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/io.github.totoshko88.RustConn.desktop && \
  mv \
    /usr/share/applications/io.github.totoshko88.RustConn.desktop \
    /usr/share/applications/rustconn-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "rustconn-pa" > /bin-name && \
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
