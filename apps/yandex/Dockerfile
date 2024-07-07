ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  curl -o \
    /tmp/yandex.deb -L \
    "https://repo.yandex.ru/yandex-browser/deb/pool/main/y/yandex-browser-stable/$(curl -sL https://repo.yandex.ru/yandex-browser/deb/pool/main/y/yandex-browser-stable/ | awk -F'(<a href="|")' '/href=/ {print $2}' | sort --version-sort | tail -1)" && \
  apt install -y --no-install-recommends \
    /tmp/yandex.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:yandex %U\"" \
    -e "s/Name=Yandex Browser/Name=Yandex PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/yandex-browser.desktop && \
  mv \
    /usr/share/applications/yandex-browser.desktop \
    /usr/share/applications/yandex-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "yandex-pa" > /bin-name && \
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
