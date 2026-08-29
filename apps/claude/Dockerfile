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
    libglib2.0-bin \
    openssh-client && \
  echo 'CLAUDE_DESKTOP_ADD_REPO="false"' > /etc/default/claude-desktop && \
  ARCH=$(dpkg --print-architecture) && \
  CLAUDE_DEB=$(curl -s \
    "https://downloads.claude.ai/claude-desktop/apt/stable/dists/stable/main/binary-${ARCH}/Packages" \
    | grep '^Filename: pool/main/c/claude-desktop/claude-desktop_' | sort -V | tail -n 1 | cut -d ' ' -f2) && \
  curl -o \
    /tmp/claude.deb -L \
    "https://downloads.claude.ai/claude-desktop/apt/stable/${CLAUDE_DEB}" && \
  apt install -y --no-install-recommends \
    /tmp/claude.deb && \
  rm -f \
    /etc/apt/sources.list.d/claude-desktop.list \
    /etc/apt/apt.conf.d/50claude-desktop \
    /usr/share/keyrings/claude-desktop-archive-keyring.asc && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e '/^\[Desktop Action/,$d' \
    -e '/^Actions=/d' \
    -e '/^#/d' \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:claude %U\"" \
    -e "s/^Name=Claude$/Name=Claude PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/com.anthropic.Claude.desktop && \
  mv \
    /usr/share/applications/com.anthropic.Claude.desktop \
    /usr/share/applications/claude-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "claude-pa" > /bin-name && \
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
