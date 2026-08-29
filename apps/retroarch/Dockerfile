ARG REPO
FROM ghcr.io/${REPO}:ubuntu-resolute AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** add libretro repo ****" && \
  mkdir -p /etc/apt/keyrings && \
  curl -o \
    /etc/apt/keyrings/libretro.asc -L \
    "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3B2BA0B6750986899B189AFF18DAAE7FECA3745F" && \
  echo \
    "deb [signed-by=/etc/apt/keyrings/libretro.asc] https://ppa.launchpadcontent.net/libretro/stable/ubuntu resolute main" > \
    /etc/apt/sources.list.d/libretro.list && \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libretro-core-info \
    retroarch \
    retroarch-assets \
    unzip && \
  echo "**** install retroarch profiles ****" && \
  curl -o \
    /tmp/autoconfig.zip \
    https://buildbot.libretro.com/assets/frontend/autoconfig.zip && \
  mkdir -p /usr/share/libretro/autoconfig && \
  unzip -q \
    /tmp/autoconfig.zip \
    -d /usr/share/libretro/autoconfig && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:retroarch %U\"" \
    -e "s/^Name=.*/Name=RetroArch PA/" \
    -e '/^TryExec=/d' \
    /usr/share/applications/com.libretro.RetroArch.desktop && \
  mv \
    /usr/share/applications/com.libretro.RetroArch.desktop \
    /usr/share/applications/retroarch-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "retroarch-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  apt-get remove -y unzip && \
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
