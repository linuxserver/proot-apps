ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    default-jdk \
    fontconfig \
    git \
    libfreetype6 \
    libxext6 \
    libxi6 \
    libxrender1 \
    libxtst6 \
    openssh-client && \
  echo "**** download idea ****" && \
  mkdir /opt/idea && \
  ARCH=$(uname -m| sed 's/x86_64/linux/g'| sed 's/aarch64/linuxARM64/') && \
  curl -o \
    /tmp/idea.tar.gz -L \
    "https://download.jetbrains.com/product?code=IIC&latest&distribution=linux&platform=${ARCH}" && \
  tar -xf \
    /tmp/idea.tar.gz -C \
    /opt/idea --strip-components=1 && \ 
  echo "**** desktop file ****" && \
  DESKTOP_FILE=/usr/share/applications/idea-pa.desktop && \
  echo '[Desktop Entry]' > ${DESKTOP_FILE} && \
  echo 'Type=Application' >> ${DESKTOP_FILE} && \
  echo 'Name=IntelliJ IDEA PA' >> ${DESKTOP_FILE} && \
  echo 'Icon=idea' >> ${DESKTOP_FILE} && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':idea %U"' >> ${DESKTOP_FILE} && \
  echo "**** set bin name ****" && \
  echo "idea-pa" > /bin-name && \
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
