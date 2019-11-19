#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://c5a9d01e.ngrok.io/project/5dd3d0f4c702c805ea84cc4a/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://c5a9d01e.ngrok.io/pull/5dd3d0f4c702c805ea84cc4a 
fi
curl -s -X POST https://c5a9d01e.ngrok.io/project/5dd3d0f4c702c805ea84cc4a/webhook/build/ssgbuild > /dev/null
hugo
curl -s -X POST https://c5a9d01e.ngrok.io/project/5dd3d0f4c702c805ea84cc4a/webhook/build/publish > /dev/null
