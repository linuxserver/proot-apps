ARG REPO
FROM ghcr.io/${REPO}:debian-sid AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    hicolor-icon-theme \
    libasound2t64 \
    libpng16-16t64 \
    libxi6 && 
  LOGISIM_VERSION=$(curl -sX GET "https://api.github.com/repos/logisim-evolution/logisim-evolution/releases/latest" \
  | awk '/tag_name/{print $4;exit}' FS='[""]') && \
  curl -o \
    /tmp/logisim.deb -L \
    "https://github.com/logisim-evolution/logisim-evolution/releases/download/${LOGISIM_VERSION}/logisim-evolution_$( echo $LOGISIM_VERSION|sed 's/^v//g')_amd64.deb" && \
  mkdir -p \
    /usr/share/desktop-directories && \
  apt install -y --no-install-recommends \
    /tmp/logisim.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:logisim %U\"" \
    -e "s/Name=Logisim-evolution/Name=Logisim-evolution PA/g" \
    -e '/^Icon=/c Icon=logisim-evolution' \
    -e '/^TryExec=/d' \
    /usr/share/applications/logisim-evolution-logisim-evolution.desktop && \
  mv \
    /usr/share/applications/logisim-evolution-logisim-evolution.desktop \
    /usr/share/applications/logisim-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "logisim-pa" > /bin-name && \
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
