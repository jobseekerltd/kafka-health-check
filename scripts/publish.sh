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

echo "> Starting publish"

APP="${PWD##*/}"
DOCKER_IMAGE="jobseeker/$APP"

docker push $DOCKER_IMAGE

echo "> Publish complete."

trap : 0
