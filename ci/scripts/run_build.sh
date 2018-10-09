#!/bin/sh

uname -a
ls -ltra

pwd

ls -ltra .m2

set -e -u -x

cd concourse-web
set -e -u +x
#apt-get update && apt-get -y upgrade
#apt-get install -y maven
echo mvn --version

ls -ltr ../.m2

mvn -Dmaven.repo.local="../.m2"  clean install
set -e -u -x

version=`cat ../version/number`

ls target/*

ls ../ -R

cp target/concourseweb*.jar ../artifactory-repository/concourse-web-$version-SNAPSHOT.jar
echo "build success"
