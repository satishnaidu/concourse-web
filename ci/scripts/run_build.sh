#!/bin/sh

uname -a
ls -ltra

pwd

ls -ltra .m2

set -e -u -x

git clone concourse-web updated-concourse-web
cd updated-concourse-web
set -e -u +x
echo mvn --version

ls -ltr ../.m2


#version=`cat ../version/number`

mvn -Dmaven.repo.local="../.m2" clean install -Dmaven.test.skip=true

VERSION=$(mvn org.apache.maven.plugins:maven-help-plugin:3.1.0:evaluate -Dexpression=project.version -q -DforceStdout)

echo "Creating tag for the for new checkins in develop branch"
git tag -a $VERSION-SNAPSHOT -m "Created tag $VERSION for the new checkins in develop"



echo "Increment snapshot version for next release"
mvn build-helper:parse-version versions:set -DnewVersion=\${parsedVersion.majorVersion}.\${parsedVersion.minorVersion}.\${parsedVersion.nextIncrementalVersion}-SNAPSHOT

git config --global user.email "satishkumar_andey@comcast.com"
git config --global user.name "sandey080"

VERSION_NEW=$(mvn org.apache.maven.plugins:maven-help-plugin:3.1.0:evaluate -Dexpression=project.version -q -DforceStdout)

git add pom.xml
git commit -m "Updated snapshot with latest version for next release "+$VERSION_NEW


echo "Build success and released the SNAPSHOT version "+ $VERSION

ls -ltra target/*

cp target/concourseweb*.jar ../artifactory-repository/concourse-web-$VERSION.jar
echo $VERSION >> ../version/number


set -e -u -x

echo "build success np"
