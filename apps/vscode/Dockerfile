ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm-av as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    git \
    gnupg2 \
    openssh-client && \
  ARCH=$(uname -m| sed 's/x86_64/amd64/g'| sed 's/aarch64/arm64/') && \
  curl -o \
    /tmp/vscode.deb -L \
    "https://packages.microsoft.com/repos/code/pool/main/c/code/$(curl -sL https://packages.microsoft.com/repos/code/pool/main/c/code/ | awk -F'(<a href="|")' '/href=/ {print $2}' | sort --version-sort | tail -3 | grep ${ARCH})" && \
  apt install -y --no-install-recommends \
    /tmp/vscode.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:vscode %U\"" \
    -e "s/Name=Visual Studio Code/Name=VSCode PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/code.desktop && \
  mv \
    /usr/share/applications/code.desktop \
    /usr/share/applications/vscode-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "vscode-pa" > /bin-name && \
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
