ARG REPO
FROM ghcr.io/${REPO}:ubuntu-noble AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt update && \
  apt install -y --no-install-recommends \
    wget curl libgtkmm-3.0-1v5 libgtkmm-3.0-1t64 cabextract unzip p7zip && \
  dpkg --add-architecture i386 && \
  apt update && \
  apt install -y --install-recommends \
    wine wine32:i386 libgles2-mesa-dev locales winetricks && \
  wget https://winegui.melroy.org/downloads/WineGUI-v2.8.1.deb && \
  dpkg -i WineGUI-v2.8.1.deb && \
  rm WineGUI-v2.8.1.deb && \
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
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /