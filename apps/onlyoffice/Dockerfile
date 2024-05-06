ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    desktop-file-utils \
    libgbm1 \
    libgl1 \
    libnss3 && \
  curl -o \
    /tmp/onlyoffice.deb -L \
    "https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb" && \
  apt install -y --no-install-recommends \
    /tmp/onlyoffice.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:onlyoffice %U\"" \
    -e "s/Name=ONLYOFFICE Desktop Editors/Name=ONLYOFFICE PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/onlyoffice-desktopeditors.desktop && \
  mv \
    /usr/share/applications/onlyoffice-desktopeditors.desktop \
    /usr/share/applications/onlyoffice-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "onlyoffice-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  apt-get remove -y \
    desktop-file-utils && \
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
