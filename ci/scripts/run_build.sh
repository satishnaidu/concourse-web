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

echo "Increment snapshot version for next release"
mvn build-helper:parse-version versions:set -DnewVersion=\${parsedVersion.majorVersion}.\${parsedVersion.minorVersion}.\${parsedVersion.nextIncrementalVersion}-SNAPSHOT

git add pom.xml
git commit -m "Updated snapshot with latest version"+$VERSION

echo "Build success and released the SNAPSHOT version "+ $VERSION

ls -ltra target/*

cp target/concourse-web*.war ../artifactory-repository/concourse-web-$VERSION.war
echo $VERSION >> ../version/number


set -e -u -x

echo "build success np"
