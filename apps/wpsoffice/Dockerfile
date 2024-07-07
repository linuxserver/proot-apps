ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install --no-install-recommends -y \
    bsdextrautils \
    libqt5gui5 \
    libsqlite3-0 \
    libxcomposite1 \
    libxslt1.1 && \
  echo "**** install wps-office ****" && \
  WPSOFFICE_VERSION=$(curl -sL https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=wps-office \
    |awk -F'=' '/^pkgver=/ {print $2}'); \
  curl -o \
    /tmp/wps.deb -L \
    "https://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/linux/${WPSOFFICE_VERSION##*.}/wps-office_${WPSOFFICE_VERSION}.XA_amd64.deb" && \
  apt install -y /tmp/wps.deb && \
  ln -s \
    /usr/lib/x86_64-linux-gnu/libtiff.so.6.0.0 \
    /usr/lib/x86_64-linux-gnu/libtiff.so.5 && \
  echo "**** customize desktop file ****" && \
  for APP in et.Spreadsheets.et pdf.PDF.wpspdf wpp.Presentation.wpp wps.Writer.wps; do \
    sed -i \
      -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:wpsoffice $(echo "$APP" | awk -F'.' '{print $3}') %U\"" \
      -e "s/Name=.*/Name=WPS $(echo "$APP" | awk -F'.' '{print $2}') PA/g" \
      -e '/^TryExec=/d' \
      /usr/share/applications/wps-office-$(echo "$APP" | awk -F'.' '{print $1}').desktop; \
    mv \
      /usr/share/applications/wps-office-$(echo "$APP" | awk -F'.' '{print $1}').desktop \
      /usr/share/applications/wps-office-$(echo "$APP" | awk -F'.' '{print $1}')-pa.desktop; \
  done && \
  echo "**** set bin name ****" && \
  echo "wpsoffice-pa" > /bin-name && \
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
