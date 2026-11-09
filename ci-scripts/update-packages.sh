#! /bin/bash
set -e

IMAGE=$1

cd apps/$IMAGE
docker build --build-arg REPO=${GITHUB_REPOSITORY,,} -t $IMAGE:latest .
docker run --rm \
  -e SYFT_FILE_METADATA_SELECTION=none \
  -e SYFT_CHECK_FOR_APP_UPDATE=false \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  -v $(pwd):/tmp \
  ghcr.io/anchore/syft:v1.26.1 \
  $IMAGE:latest -q -o table=/tmp/syft_table.txt
CID=$(docker create $IMAGE:latest /bin/true)
docker cp $CID:/upstream-versions upstream_versions.tmp 2>/dev/null || touch upstream_versions.tmp
docker rm -f $CID >/dev/null
if awk 'NF != 2 || $2 == "null" {bad=1; print "Bad upstream version line: " $0} END {exit !bad}' upstream_versions.tmp; then
  rm -f upstream_versions.tmp syft_table.txt
  exit 1
fi
{
  cat syft_table.txt
  LC_ALL=C sort upstream_versions.tmp | awk '{printf "%-31s %-37s %s\n", $1, $2, "upstream"}'
} > package_versions_check.txt
rm -f upstream_versions.tmp syft_table.txt

if [ ! -f 'package_versions.txt' ]; then
  mv package_versions_check.txt package_versions.txt
elif ! diff -q package_versions_check.txt package_versions.txt; then
  mv package_versions_check.txt package_versions.txt
else
  rm -f package_versions_check.txt
fi
