ARG REPO
FROM ghcr.io/${REPO}:alpine-321 AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    telegram-desktop && \
  echo "**** customize desktop file ****" && \
  echo '[Desktop Entry]' > /usr/share/applications/telegram-pa.desktop && \
  echo 'Name=Telegram PA' >> /usr/share/applications/telegram-pa.desktop && \
  echo 'Exec=/bin/sh -c "$HOME/.local/bin/proot-apps run ghcr.io/'${REPO}':telegram %U"' >> /usr/share/applications/telegram-pa.desktop && \
  echo 'Icon=telegram' >> /usr/share/applications/telegram-pa.desktop && \
  echo 'Terminal=false' >> /usr/share/applications/telegram-pa.desktop && \
  echo 'Type=Application' >> /usr/share/applications/telegram-pa.desktop && \
  echo 'MimeType=x-scheme-handler/tg;' >> /usr/share/applications/telegram-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "telegram-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
