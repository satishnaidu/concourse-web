#!/bin/sh

uname -a
ls -ltra

set -e -u -x

version=`cd concourse-web && git describe --abbrev=0 --tags`
echo "deploy_version " $deploy_version
if [ -z $deploy_version ]
then
	version=$deploy_version
fi

if [ -z $$deploy_version ]
then
   echo "-z $deploy_version : string length is zero"
else
   echo "-z $deploy_version : string length is not zero"
fi

#version=`cat ./version/number`
echo "version number "+$version

set +x

ls -lR
curl -o ./deploy-to-dev/concourse-web-$version.jar  -u $ARTIFACTORY_USER:$ARTIFACTORY_PW -X GET $ARTIFACTORY_URL/ESL/libs-snapshot-local/concourse-web-$version-SNAPSHOT.jar

echo "Succesfully downloaded artifactory"

ls -R ../*

set -x


current_app_name=concourse-web-$version

sshpass -p 'Comcast@12' scp  -o StrictHostKeyChecking=no ./deploy-to-dev/concourse-web-$version.jar sandey080@10.0.0.243://Users/sandey080/Comcast/Project/Codebase/workspace/concourse/concourse-web

echo "Copying success to target location"