ARG REPO
FROM ghcr.io/${REPO}:ubuntu-jammy AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    wget \
    gnupg2 \
    ca-certificates \
    libxss1 \
    libasound2 \
    libgtk-3-0 \
    libnss3 \
    libx11-6 \
    libxext6 \
    libxrender1 \
    libxtst6 \
    libgbm1 && \
  wget -q -O - https://workspaces-client-linux-public-key.s3-us-west-2.amazonaws.com/ADB332E7.asc | apt-key add - && \
  echo "deb [arch=amd64] https://d3nt0h4h6pmmc4.cloudfront.net/ubuntu jammy main" > /etc/apt/sources.list.d/amazon-workspaces-clients.list && \
  apt-get update && \
  apt-get install -y workspacesclient && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:aws-workspaces %U\"" \
    -e "s/Name=Amazon WorkSpaces/Name=AWS WorkSpaces Client PA/g" \
    -e "/^Icon=/c Icon=aws-workspaces" \
    -e '/^TryExec=/d' \
    /usr/share/applications/com.amazon.workspacesclient.desktop && \
  mv \
    /usr/share/applications/com.amazon.workspacesclient.desktop \
    /usr/share/applications/aws-workspaces-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "aws-workspaces-pa" > /bin-name && \
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
RUN chmod +x /entrypoint /install /remove

FROM scratch
COPY --from=rootfs / /
