#!/usr/bin/env bash

set -eu
set -o pipefail

mkdir -p .fake

# liberated from https://stackoverflow.com/a/18443300/433393
realpath() {
  OURPWD=$PWD
  cd "$(dirname "$1")"
  LINK=$(readlink "$(basename "$1")")
  while [ "$LINK" ]; do
    cd "$(dirname "$LINK")"
    LINK=$(readlink "$(basename "$1")")
  done
  REALPATH="$PWD/$(basename "$1")"
  cd "$OURPWD"
  echo "$REALPATH"
}

FAKE_VERSION="5.12.0"
TOOL_PATH=$(realpath ".fake/v${FAKE_VERSION}")

if ! [ -e "$TOOL_PATH/fake" ]; then
  mkdir -p $(dirname $TOOL_PATH)
  dotnet tool install fake-cli --version 5.12.0 --tool-path "$TOOL_PATH"
  dotnet tool install GitVersion.Tool --version 4.0.1-beta1-59 --tool-path "$TOOL_PATH"
fi

export PATH="$TOOL_PATH:$PATH"
fake "$@"
