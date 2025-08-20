ARG REPO
FROM ghcr.io/${REPO}:alpine-322 AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    anki && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:anki %U\"" \
    -e "s/Name=Anki/Name=Anki PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/anki.desktop && \
  mv \
    /usr/share/applications/anki.desktop \
    /usr/share/applications/anki-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "anki-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
