#!/usr/bin/env bash

ME=`basename "$0"`

abort()
{
    echo "An error occurred. Exiting..." >&2
    exit 1
}

usage()
{
    echo "Usage: $ME [build number]" >&2
    exit 1
}

trap 'abort' 0

set -e

BUILD_NUMBER=$1
if [ -z "$BUILD_NUMBER" ]; then usage; fi

echo "> Starting build"

APP="${PWD##*/}"
DOCKER_IMAGE="jobseeker/$APP"

echo ">> Cleaning output directory"
rm -rf build/

echo ">> Build and test app"
docker build --rm=false --build-arg APP=$APP -f Dockerfile.build -t "$APP-builder" .

echo ">> Copying output"
container_id=$(docker create "$APP-builder") && docker cp $container_id:/build .

echo ">> Building app container"
docker build --rm=false --build-arg APP=$APP -t "$DOCKER_IMAGE:$BUILD_NUMBER" .
docker tag "$DOCKER_IMAGE:$BUILD_NUMBER" "$DOCKER_IMAGE:latest"

echo "> Build complete."

trap : 0
