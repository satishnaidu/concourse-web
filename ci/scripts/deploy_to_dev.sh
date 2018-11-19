#!/bin/sh

uname -a
ls -ltra

set -e -u -x

version=`git describe --abbrev=0 --tags`
#version=`cat ./version/number`
echo "version number "+$version

set +x

ls -lR
curl -o ./deploy-to-dev/concourse-web-$version.jar  -u $ARTIFACTORY_USER:$ARTIFACTORY_PW -X GET $ARTIFACTORY_URL/ESL/libs-snapshot-local/concourse-web-$version-SNAPSHOT.jar

echo "Succesfully downloaded artifactory"

ls -R ../*

set -x


current_app_name=concourse-web-$version

sshpass -p 'Comcast@12' scp  -o StrictHostKeyChecking=no ./deploy-to-dev/concourse-web-$version.jar sandey080@10.169.236.89://Users/sandey080/Comcast/Project/Codebase/workspace/concourse/concourse-web

echo "Copying success to target location"