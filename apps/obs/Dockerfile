ARG REPO
FROM ghcr.io/${REPO}:ubuntu-noble AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    gnupg \
    hicolor-icon-theme && \
  apt-key adv \
    --keyserver hkp://keyserver.ubuntu.com:80 \
    --recv-keys BC7345F522079769F5BBE987EFC71127F425E228 && \
  echo \
    "deb https://ppa.launchpadcontent.net/obsproject/obs-studio/ubuntu noble main" > \
    /etc/apt/sources.list.d/obs.list && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    obs-studio && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:obs %U\"" \
    -e "s/Name=OBS Studio/Name=OBS Studio PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/com.obsproject.Studio.desktop && \
  mv \
    /usr/share/applications/com.obsproject.Studio.desktop \
    /usr/share/applications/obs-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "obs-pa" > /bin-name && \
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
