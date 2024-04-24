ARG REPO
FROM ghcr.io/${REPO}:debian-bookworm-av as rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  SLACK_VERSION=$(curl -sL https://slack.com/downloads/linux \
    | awk -F'(Version |</span><strong>)' '/page-downloads__hero__meta-text__version/ {print $2}') && \
  curl -o \
    /tmp/slack.deb -L \
    "https://downloads.slack-edge.com/releases/linux/${SLACK_VERSION}/prod/x64/slack-desktop-${SLACK_VERSION}-amd64.deb" && \
  apt install -y --no-install-recommends \
    /tmp/slack.deb && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:slack %U\"" \
    -e "s/Name=Slack/Name=Slack PA/g" \
    -e "/^Icon=/c Icon=slack" \
    -e '/^TryExec=/d' \
    /usr/share/applications/slack.desktop && \
  mv \
    /usr/share/applications/slack.desktop \
    /usr/share/applications/slack-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "slack-pa" > /bin-name && \
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
