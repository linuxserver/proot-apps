ARG REPO
FROM ghcr.io/${REPO}:ubuntu-resolute AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** add xtradeb repo ****" && \
  mkdir -p /etc/apt/keyrings && \
  curl -o \
    /etc/apt/keyrings/xtradeb.asc -L \
    "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x5301FA4FD93244FBC6F6149982BB6851C64F6880" && \
  echo \
    "deb [signed-by=/etc/apt/keyrings/xtradeb.asc] https://ppa.launchpadcontent.net/xtradeb/apps/ubuntu resolute main" > \
    /etc/apt/sources.list.d/xtradeb.list && \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    firefox \
    ^firefox-locale && \
  echo "**** default firefox settings ****" && \
  FIREFOX_SETTING="/usr/lib/firefox/browser/defaults/preferences/firefox.js" && \
  echo 'pref("security.sandbox.warn_unprivileged_namespaces", false);' > ${FIREFOX_SETTING} && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:firefox %U\"" \
    -e "s/^Name=Firefox.*/Name=Firefox PA/" \
    -e '/^TryExec=/d' \
    /usr/share/applications/firefox.desktop && \
  mv \
    /usr/share/applications/firefox.desktop \
    /usr/share/applications/firefox-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "firefox-pa" > /bin-name && \
  echo "**** replace dash with busybox sh ****" && \
  apt-get install -y --no-install-recommends \
    busybox-static && \
  ln -sf busybox /usr/bin/sh && \
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
