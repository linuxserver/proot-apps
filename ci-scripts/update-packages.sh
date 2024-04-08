#! /bin/bash

cd apps
IMAGES=$(ls -1)
IFS=$'\n'

# Loop through images and update package versions if needed
for IMAGE in $IMAGES; do
  cd $IMAGE
  docker build --build-arg REPO=${GITHUB_REPOSITORY} -t $IMAGE:latest .
  docker run --rm \
    -v /var/run/docker.sock:/var/run/docker.sock:ro \
    -v $(pwd):/tmp \
    ghcr.io/anchore/syft:latest \
    $IMAGE:latest -o table=/tmp/package_versions_check.txt
  if [ ! -f 'package_versions.txt' ]; then
    mv package_versions_check.txt package_versions.txt
  elif ! diff -q package_versions_check.txt package_versions.txt; then
    mv package_versions_check.txt package_versions.txt
  else
    rm -f package_versions_check.txt
  fi
  docker rmi $IMAGE:latest
  docker system prune -af
  cd ..
done

cd ..
