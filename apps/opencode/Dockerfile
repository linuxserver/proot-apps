ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    git \
    gnupg2 \
    openssh-client && \
  curl -o \
    /tmp/opencode.deb -L \
    "https://opencode.ai/download/stable/linux-x64-deb" && \
  apt install -y --no-install-recommends \
    /tmp/opencode.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:opencode %U\"" \
    -e "s/^Name=OpenCode$/Name=OpenCode PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/ai.opencode.desktop.desktop && \
  mv \
    /usr/share/applications/ai.opencode.desktop.desktop \
    /usr/share/applications/opencode-pa.desktop && \
  rm -f /usr/share/applications/opencode-desktop.desktop && \
  echo "**** set bin name ****" && \
  echo "opencode-pa" > /bin-name && \
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
