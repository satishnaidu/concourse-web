#!/bin/sh

uname -a
ls -ltra

set -e -u -x

version=`cat ./version/number`

set +x

ls -lR
curl -o ./deploy-to-dev/concourse-web-$version.jar  -u $ARTIFACTORY_USER:$ARTIFACTORY_PW -X GET $ARTIFACTORY_URL/ESL/libs-snapshot-local/concourse-web-$version-SNAPSHOT.jar

echo "Succesfully downloaded artifactory"

ls -R ../*

set -x


current_app_name=concourse-web-$version

scp ./deploy-to-dev/concourse-web-$version.jar root@10.0.0.243://Users/sandey080/Comcast/Project/Codebase/workspace/concourse/concourse-web

echo "Copying success to target location"