ARG REPO
FROM ghcr.io/${REPO}:ubuntu-resolute AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** add mame repo ****" && \
  mkdir -p /etc/apt/keyrings && \
  curl -o \
    /etc/apt/keyrings/mame.asc -L \
    "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xBD90C31EDB703FB5C74D68DBE309D18C36773207" && \
  echo \
    "deb [signed-by=/etc/apt/keyrings/mame.asc] https://ppa.launchpadcontent.net/c.falco/mame/ubuntu resolute main" > \
    /etc/apt/sources.list.d/mame.list && \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    mame && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:mame %U\"" \
    -e "s/^Name=.*/Name=MAME PA/" \
    -e '/^Name\[/d' \
    -e '/^TryExec=/d' \
    /usr/share/applications/mame.desktop && \
  mv \
    /usr/share/applications/mame.desktop \
    /usr/share/applications/mame-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "mame-pa" > /bin-name && \
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
