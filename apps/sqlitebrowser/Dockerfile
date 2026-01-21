ARG REPO
FROM ghcr.io/${REPO}:alpine-323 AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    sqlitebrowser && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:sqlitebrowser %U\"" \
    -e "s/Name=DB Browser for SQLite/Name=SQLitebrowser PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/sqlitebrowser.desktop && \
  mv \
    /usr/share/applications/sqlitebrowser.desktop \
    /usr/share/applications/sqlitebrowser-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "sqlitebrowser-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
