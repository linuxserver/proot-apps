ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libasound2t64 \
    libegl1 \
    libgbm1 \
    libgles2 \
    libsecret-1-0 && \
  MOTRIX_VERSION=$(curl -sX GET "https://api.github.com/repos/agalwood/Motrix/releases/latest" \
    | jq -r '.tag_name') && \
  curl -o \
    /tmp/motrix.deb -L \
    "https://github.com/agalwood/Motrix/releases/download/${MOTRIX_VERSION}/Motrix_$(echo ${MOTRIX_VERSION}| sed 's/^v//g')_$(dpkg --print-architecture).deb" && \
  apt-get install -y --no-install-recommends \
    /tmp/motrix.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:motrix %U\"" \
    -e "s/^Name=Motrix$/Name=Motrix PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/motrix.desktop && \
  mv \
    /usr/share/applications/motrix.desktop \
    /usr/share/applications/motrix-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "motrix-pa" > /bin-name && \
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
