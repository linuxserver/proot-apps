ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    git \
    libgtk-3-bin \
    libatk1.0 \
    libatk-bridge2.0 \
    libnss3 \
    libsecret-1-0 \
    python3-xdg && \
  if [ "$(uname -m)" = "x86_64" ]; then \
    URL="https://dl.pstmn.io/download/latest/linux_64"; \
  else \
    URL="https://dl.pstmn.io/download/latest/linux_arm64"; \
  fi && \
  curl -o \
    /tmp/postman.tar.gz -L \
    "${URL}" && \
  tar -xf \
    /tmp/postman.tar.gz -C \
    /opt/ && \
  echo "**** customize desktop file ****" && \
  echo '[Desktop Entry]' > /usr/share/applications/postman-pa.desktop && \
  echo 'Type=Application' >> /usr/share/applications/postman-pa.desktop && \
  echo 'Name=Postman PA' >> /usr/share/applications/postman-pa.desktop && \
  echo 'Icon=postman' >> /usr/share/applications/postman-pa.desktop && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':postman %U"' >> /usr/share/applications/postman-pa.desktop && \
  echo 'Comment=Postman GUI' >> /usr/share/applications/postman-pa.desktop && \
  echo 'Categories=Development;Code;' >> /usr/share/applications/postman-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "postman-pa" > /bin-name && \
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
