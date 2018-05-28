#!/bin/sh
#
# Usage: run.sh [DIRECTORY...]
#
# Directories passed as arguments will be mounted under the home directory of
# the docker container.

set -euf -o pipefail

if ! command -v docker; then
  echo "Docker isn't installed" 1>&2
  exit 1
fi

name="${NAME:-devbox}"

if [ "$(docker ps -qa --filter=name="$name")" ]; then
  docker attach "$name"
else
  volumes=""

  for dirname in "$@"; do
    dirpath="$(cd "$dirname" && pwd)"
    basename=$(basename "$dirpath")
    volumes="$volumes -v '$dirpath':'/home/dev/$basename'"
  done

  docker pull alexgenco/devbox:latest
  docker run --detach-keys="ctrl-a,d" --rm --name="$name" $volumes -it alexgenco/devbox:latest
fi
