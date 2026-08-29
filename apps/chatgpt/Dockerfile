ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS rootfs
ARG REPO

# Add local files
COPY /root /

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    git \
    gnupg2 \
    openssh-client && \
  echo 'repo_add_once="false"' > /etc/default/chatgpt && \
  ARCH=$(dpkg --print-architecture) && \
  curl -o \
    /tmp/chatgpt.deb -L \
    "https://persistent.oaistatic.com/codex-app-prod/linux/deb/latest/chatgpt_${ARCH}.deb" && \
  apt install -y --no-install-recommends \
    /tmp/chatgpt.deb && \
  rm -f \
    /etc/apt/sources.list.d/chatgpt.sources \
    /usr/share/keyrings/chatgpt-archive-keyring.gpg && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:chatgpt %U\"" \
    -e "s/^Name=ChatGPT$/Name=ChatGPT PA/g" \
    -e 's/x-scheme-handler\/http;x-scheme-handler\/https;//' \
    -e '/^TryExec=/d' \
    /usr/share/applications/chatgpt.desktop && \
  mv \
    /usr/share/applications/chatgpt.desktop \
    /usr/share/applications/chatgpt-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "chatgpt-pa" > /bin-name && \
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
