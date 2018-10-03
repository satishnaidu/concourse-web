#!/bin/sh

uname -a
ls -ltra

set -eux

git clone concourse-web updated-concourse-web

cd updated-concourse-web

version=`cat ../version/number`

git tag concourse-web-v$version.build
