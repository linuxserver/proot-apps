ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    freecad \
    python3-pyside2.qtwebchannel \
    python3-pyside2.qtwebengine* && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:freecad %U\"" \
    -e "s/Name=FreeCAD/Name=FreeCAD PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/org.freecadweb.FreeCAD.desktop && \
  mv \
    /usr/share/applications/org.freecadweb.FreeCAD.desktop \
    /usr/share/applications/freecad-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "freecad-pa" > /bin-name && \
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
