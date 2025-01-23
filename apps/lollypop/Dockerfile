ARG REPO
FROM ghcr.io/${REPO}:alpine-321 AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    adwaita-icon-theme \
    py3-beautifulsoup4 \
    lollypop \
    youtube-dl && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:lollypop %U\"" \
    -e "s/Name=Lollypop/Name=Lollypop PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/org.gnome.Lollypop.desktop && \
  mv \
    /usr/share/applications/org.gnome.Lollypop.desktop \
    /usr/share/applications/lollypop-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "lollypop-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
