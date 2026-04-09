ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    desktop-file-utils \
    gsettings-desktop-schemas \
    libgbm1 \
    libgl1 \
    libnss3 && \
  ONLYOFFICE_VERSION=$(curl -sX GET "https://api.github.com/repos/ONLYOFFICE/DesktopEditors/releases/latest" \
    | awk '/tag_name/{print $4;exit}' FS='[""]') && \
  curl -o \
    /tmp/onlyoffice.deb -L \
    "https://github.com/ONLYOFFICE/DesktopEditors/releases/download/${ONLYOFFICE_VERSION}/onlyoffice-desktopeditors_amd64.deb" && \
  apt-get update && \
  apt-get install -y \
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
