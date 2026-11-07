ARG REPO
FROM ghcr.io/${REPO}:alpine-324 AS build

# Grab the X11 (GTK3) build, emacs-gtk3 and emacs-pgtk conflict as packages
# but ship identical lisp, only the binary and its fingerprinted pdmp differ
RUN \
  echo "**** install emacs-gtk3 ****" && \
  apk add --no-cache \
    emacs-gtk3 && \
  echo "**** grab x11 binary and pdmp ****" && \
  mkdir -p /root-out/usr/libexec/emacs-x11 && \
  cp \
    /usr/bin/emacs \
    /root-out/usr/libexec/emacs-x11/emacs && \
  cd / && \
  tar -cf - usr/lib/emacs/*/*/emacs-*.pdmp | tar -xf - -C /root-out

FROM ghcr.io/${REPO}:alpine-324 AS rootfs
ARG REPO

# Install packages
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    emacs-pgtk && \
  echo "**** customize desktop file ****" && \
  sed -i \
    -e "/^Exec=/c Exec=/bin/sh -c \"\$HOME\/.local\/bin\/proot-apps run ghcr.io/${REPO}:emacs %F\"" \
    -e "s/^Name=Emacs$/Name=Emacs PA/g" \
    -e '/^TryExec=/d' \
    /usr/share/applications/emacs.desktop && \
  mv \
    /usr/share/applications/emacs.desktop \
    /usr/share/applications/emacs-pa.desktop && \
  echo "**** set bin name ****" && \
  echo "emacs-pa" > /bin-name && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY --from=build /root-out /

COPY ./entrypoint /entrypoint
COPY ./install /install
COPY ./remove /remove

FROM scratch
COPY --from=rootfs / /
