#!/bin/sh

uname -a
ls -ltra

set -e -u -x

cd concourse-web
set -e -u +x
mvn clean install
set -e -u -x

version=`cat ../version/number`
popd
echo "build success"
