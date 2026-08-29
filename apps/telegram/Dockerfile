ARG REPO
FROM ghcr.io/${REPO}:debian-trixie AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libgtk-3-0 \
    libopengl0 \
    libwayland-cursor0 \
    libwayland-egl1 \
    libxcb-keysyms1 \
    libxcb-record0 \
    xz-utils && \
  echo "**** install telegram ****" && \
  TELEGRAM_VERSION=$(curl -sX GET "https://api.github.com/repos/telegramdesktop/tdesktop/releases/latest" \
    | jq -r '.tag_name' | sed 's|^v||') && \
  mkdir -p /opt/telegram && \
  curl -o \
    /tmp/telegram.tar.xz -L \
    "https://github.com/telegramdesktop/tdesktop/releases/download/v${TELEGRAM_VERSION}/tsetup.${TELEGRAM_VERSION}.tar.xz" && \
  tar xf \
    /tmp/telegram.tar.xz -C \
    /opt/telegram/ --strip-components=1 && \
  ln -s \
    /opt/telegram/Telegram \
    /usr/bin/Telegram && \
  mkdir -p \
    /usr/share/icons/hicolor/256x256/apps && \
  curl -o \
    /usr/share/icons/hicolor/256x256/apps/org.telegram.desktop.png -L \
    "https://raw.githubusercontent.com/telegramdesktop/tdesktop/v${TELEGRAM_VERSION}/Telegram/Resources/art/icon256.png" && \
  echo "**** customize desktop file ****" && \
  echo '[Desktop Entry]' > /usr/share/applications/telegram-pa.desktop && \
  echo 'Name=Telegram PA' >> /usr/share/applications/telegram-pa.desktop && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':telegram %U"' >> /usr/share/applications/telegram-pa.desktop && \
  echo 'Icon=org.telegram.desktop' >> /usr/share/applications/telegram-pa.desktop && \
  echo 'Terminal=false' >> /usr/share/applications/telegram-pa.desktop && \
  echo 'Type=Application' >> /usr/share/applications/telegram-pa.desktop && \
  echo 'MimeType=x-scheme-handler/tg;' >> /usr/share/applications/telegram-pa.desktop && \
  echo 'Categories=Chat;Network;InstantMessaging;Qt;' >> /usr/share/applications/telegram-pa.desktop && \
  echo 'Keywords=tg;chat;im;messaging;messenger;sms;tdesktop;' >> /usr/share/applications/telegram-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "telegram-pa" > /bin-name && \
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
