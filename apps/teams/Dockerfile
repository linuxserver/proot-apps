ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  TEAMS_VERSION=$(curl -sX GET "https://api.github.com/repos/IsmaelMartinez/teams-for-linux/releases/latest" \
    | jq -r '.tag_name') && \
  curl -o \
    /tmp/teams.deb -L \
    "https://github.com/IsmaelMartinez/teams-for-linux/releases/download/${TEAMS_VERSION}/teams-for-linux_$(echo ${TEAMS_VERSION}| sed 's/^v//g')_amd64.deb" && \
  apt-get install -y --no-install-recommends \
    /tmp/teams.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:teams %U\"" \
    -e "s/^Name=Teams for Linux$/Name=Teams for Linux PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/teams-for-linux.desktop && \
  mv \
    /usr/share/applications/teams-for-linux.desktop \
    /usr/share/applications/teams-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "teams-pa" > /bin-name && \
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
