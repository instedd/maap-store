#!/bin/bash
set -eo pipefail

# This will load the script from this repository. Make sure to point to a specific commit so the build continues to work
# event if breaking changes are introduced in this repository
source <(curl -s https://raw.githubusercontent.com/manastech/ci-docker-builder/e53ee8c387a4e252bff57a8bb92e32f2b4230737/build.sh)

# Prepare the build
dockerSetup

# Write a VERSION file for the footer
echo $VERSION > VERSION

# Build and push the Docker image
dockerBuildAndPush
