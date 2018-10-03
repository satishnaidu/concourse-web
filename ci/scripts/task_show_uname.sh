#!/bin/sh

uname -a
ls -ltra

set -e -u -x

pushd concourse-web
set -e -u +x
mvn clean install
set -e -u -x

version=`cat ../version/number`
popd
echo "build success"
