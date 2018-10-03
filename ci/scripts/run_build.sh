#!/bin/bash

set -e -u -x

chmod +x concourse-web/mvnw

export TERM=${TERM:-dumb}

pushd concourse-web

set -e -u +x

#./mvnw clean build zipTestSources --debug --refresh-dependencies --info -Partifactory_user=$ARTIFACTORY_USER -Partifactory_password=$ARTIFACTORY_PW -Partifactory_contextUrl=$ARTIFACTORY_URL

mvn clean install

set -e -u -x

version=`cat ../version/number`

popd

#cp ./concourse-web/target/concourse-web*.jar ./artifactory-repository/location-service-$version.jar


