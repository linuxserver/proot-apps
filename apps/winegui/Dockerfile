ARG REPO
FROM ghcr.io/${REPO}:ubuntu-noble AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt update && \
  apt install -y --no-install-recommends \
    wget \
    unzip \
    p7zip \
    locales \
    libgtkmm-3.0-1v5 \
    libgtkmm-3.0-1t64 \
    gpg \
    cabextract && \
  dpkg --add-architecture i386 && \
  mkdir -pm755 /etc/apt/keyrings && \
  wget -O - https://dl.winehq.org/wine-builds/winehq.key | gpg --dearmor -o /etc/apt/keyrings/winehq-archive.key - && \
  wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/noble/winehq-noble.sources && \
  apt update && \
  apt install -y --install-recommends \
    libgles2-mesa-dev \
    winehq-stable \
    winetricks && \
  WINEGUI_VERSION=$(curl -sX GET "https://api.github.com/repos/winegui/WineGUI/releases/latest" \
    | awk '/tag_name/{print $4;exit}' FS='[""]') && \
  curl -o \
  /tmp/winegui.deb -L \
    https://github.com/winegui/WineGUI/releases/download/${WINEGUI_VERSION}/WineGUI-${WINEGUI_VERSION}-noble.deb && \
  apt install -y \
    /tmp/winegui.deb  && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:winegui %U\"" \
    -e "s/Name=WineGUI/Name=WineGUI PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/winegui.desktop && \
  mv \
    /usr/share/applications/winegui.desktop \
    /usr/share/applications/winegui-pa.desktop && \
  echo "**** gen locales ****" && \
  locale-gen en_US.UTF-8 && \
  echo "**** set bin name ****" && \
  echo "winegui-pa" > /bin-name && \
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
