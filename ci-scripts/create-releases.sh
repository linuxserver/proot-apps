#!/bin/bash

set -e

GH_USER=$(echo ${GITHUB_REPOSITORY} | awk -F'/' '{print $1}')
GH_REPO=$(echo ${GITHUB_REPOSITORY} | awk -F'/' '{print $2}')

for ARCH in amd64 arm64; do

  # Add jq and our script
  rm -Rf dist/
  mkdir -p dist
  cp proot-apps dist/
  sed -i \
    -e "s/REPLACE_USER/${GH_USER}/g" \
    -e "s/REPLACE_REPO/${GH_REPO}/g" \
    dist/proot-apps
  JQ_RELEASE=$(curl -sX GET "https://api.github.com/repos/jqlang/jq/releases/latest" \
    | awk '/tag_name/{print $4;exit}' FS='[""]');
  curl -L \
    -o dist/jq \
    https://github.com/jqlang/jq/releases/download/${JQ_RELEASE}/jq-linux-${ARCH}
  curl -L \
    -o dist/ncat \
    https://github.com/${GH_USER}/${GH_REPO}/raw/bins/ncat/ncat-${ARCH}

  # Compile proot
  cd ci-scripts
  docker buildx build --load --platform linux/${ARCH} --tag build-${ARCH} -f Dockerfile.proot-builder .
  cd ..
  docker run --rm -v $(pwd)/dist:/mnt build-${ARCH}

  # Create dist tarball
  UNAME_ARCH=$(echo $ARCH | sed -e 's/amd64/x86_64/g' -e 's/arm64/aarch64/g')
  cd dist/
  chmod +x * || :
  tar -czf proot-apps-${UNAME_ARCH}.tar.gz *
  mv proot-apps-${UNAME_ARCH}.tar.gz ../
  cd ..

  # Cleanup
  rm -Rf proot/ dist/
done
