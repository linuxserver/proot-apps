ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y \
    libxkbcommon-x11-0 \
    libxdamage1 \
    libxcomposite1 \
    libnss3 \
    libgtk-3-0 \
    libcups2 \
    libatspi2.0-0 \
    libatk-bridge2.0-0 \
    libatk1.0-0 && \
  JOPLIN_VERSION=$(curl -sX GET "https://api.github.com/repos/laurent22/joplin/releases/latest" \
    | awk '/tag_name/{print $4;exit}' FS='[""]') && \
  curl -o \
    /tmp/joplin.deb -L \
    "https://github.com/laurent22/joplin/releases/download/${JOPLIN_VERSION}/Joplin-$(echo ${JOPLIN_VERSION}| sed 's/^v//g').deb" && \
  apt-get install -y \
    /tmp/joplin.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:joplin %U\"" \
    -e "s/Name=Joplin/Name=Joplin PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/joplin.desktop && \
  mv \
    /usr/share/applications/joplin.desktop \
    /usr/share/applications/joplin-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "joplin-pa" > /bin-name && \
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
