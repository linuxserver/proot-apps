ARG REPO
FROM ghcr.io/${REPO}:ubuntu-resolute AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** add pcsx2 repo ****" && \
  mkdir -p /etc/apt/keyrings && \
  curl -o \
    /etc/apt/keyrings/pcsx2.asc -L \
    "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xD7B449CFE17E659E5A12EE8EDD6EEEA2BD747717" && \
  echo \
    "deb [signed-by=/etc/apt/keyrings/pcsx2.asc] https://ppa.launchpadcontent.net/pcsx2-team/pcsx2-daily/ubuntu resolute main" > \
    /etc/apt/sources.list.d/pcsx2.list && \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    pcsx2 && \
  echo "**** dereference font symlinks ****" && \
  for FONT in /usr/share/PCSX2/resources/fonts/*; do \
    if [ -L "${FONT}" ]; then cp -L "${FONT}" "${FONT}.tmp" && mv "${FONT}.tmp" "${FONT}"; fi; \
  done && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:pcsx2 %U\"" \
    -e "s/^Name=.*/Name=PCSX2 PA/" \
    -e '/^TryExec=/d' \
    /usr/share/applications/pcsx2-qt.desktop && \
  mv \
    /usr/share/applications/pcsx2-qt.desktop \
    /usr/share/applications/pcsx2-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "pcsx2-pa" > /bin-name && \
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
