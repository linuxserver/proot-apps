ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    default-jdk \
    git \
    libswt-gtk-4-java \
    libswt-gtk-4-jni \
    openssh-client && \
  echo "**** download eclipse ****" && \
  ECLIPSE_PATH=$(curl -sL https://mirrors.xmission.com/eclipse/technology/epp/downloads/release/release.xml \
    | awk -F'(<present>|</present>)' '/<present>/ {print $2}') && \
  curl -o \
    /tmp/eclipse.tar.gz -L \
    "https://mirrors.xmission.com/eclipse/technology/epp/downloads/release/${ECLIPSE_PATH}/eclipse-java-$(echo $ECLIPSE_PATH|sed 's:/:-:g')-linux-gtk-$(uname -m).tar.gz" && \
  tar -xf \
    /tmp/eclipse.tar.gz -C \
    /opt/ && \ 
  echo "**** desktop file ****" && \
  DESKTOP_FILE=/usr/share/applications/eclipsejava-pa.desktop && \
  echo '[Desktop Entry]' > ${DESKTOP_FILE} && \
  echo 'Type=Application' >> ${DESKTOP_FILE} && \
  echo 'Name=Eclipse Java PA' >> ${DESKTOP_FILE} && \
  echo 'Icon=eclipsejava' >> ${DESKTOP_FILE} && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':eclipsejava %U"' >> ${DESKTOP_FILE} && \
  echo "**** set bin name ****" && \
  echo "eclipsejava-pa" > /bin-name && \
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
