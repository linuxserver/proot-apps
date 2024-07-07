ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    fontconfig \
    git \
    libfreetype6 \
    libxext6 \
    libxi6 \
    libxrender1 \
    libxtst6 \
    openssh-client \
    python3 \
    python3-dev \
    python3-pip \
    python3-virtualenv && \
  echo "**** download pycharm ****" && \
  mkdir /opt/pycharm && \
  ARCH=$(uname -m| sed 's/x86_64/linux/g'| sed 's/aarch64/linuxARM64/') && \
  curl -o \
    /tmp/pycharm.tar.gz -L \
    "https://download.jetbrains.com/product?code=PCC&latest&distribution=linux&platform=${ARCH}" && \
  tar -xf \
    /tmp/pycharm.tar.gz -C \
    /opt/pycharm --strip-components=1 && \ 
  echo "**** desktop file ****" && \
  DESKTOP_FILE=/usr/share/applications/pycharm-pa.desktop && \
  echo '[Desktop Entry]' > ${DESKTOP_FILE} && \
  echo 'Type=Application' >> ${DESKTOP_FILE} && \
  echo 'Name=PyCharm PA' >> ${DESKTOP_FILE} && \
  echo 'Icon=pycharm' >> ${DESKTOP_FILE} && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':pycharm %U"' >> ${DESKTOP_FILE} && \
  echo "**** set bin name ****" && \
  echo "pycharm-pa" > /bin-name && \
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
