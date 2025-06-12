#! /bin/bash
set -e

IMAGE=$1

cd apps/$IMAGE
docker build --build-arg REPO=${GITHUB_REPOSITORY,,} -t $IMAGE:latest .
docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  -v $(pwd):/tmp \
  ghcr.io/anchore/syft:v1.26.1 \
  $IMAGE:latest -o table=/tmp/package_versions_check.txt
if [ ! -f 'package_versions.txt' ]; then
  mv package_versions_check.txt package_versions.txt
elif ! diff -q package_versions_check.txt package_versions.txt; then
  mv package_versions_check.txt package_versions.txt
else
  rm -f package_versions_check.txt
fi
