#!/bin/sh

uname -a
ls -ltra

set -e -u -x

cd concourse-web
set -e -u +x
apt-get update && apt-get -y upgrade
apt-get install -y maven
echo mvn --version

mvn clean install
set -e -u -x

version=`cat ../version/number`

echo "Generated target need to push the jar to repository"
ls target/*
echo "Build success"
