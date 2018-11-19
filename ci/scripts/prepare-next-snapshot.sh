#!/bin/sh

uname -a
ls -ltra
pwd
set -e -u -x

git clone concourse-web updated-concourse-web
cd updated-concourse-web
set -e -u +x

ls -ltr ../.m2

git config --global user.email "satishkumar_andey@comcast.com"
git config --global user.name "sandey080"

git pull origin develop
echo "Increment snapshot version for next release"
mvn build-helper:parse-version versions:set -DnewVersion=\${parsedVersion.majorVersion}.\${parsedVersion.minorVersion}.\${parsedVersion.nextIncrementalVersion}-SNAPSHOT

echo "Generating next release version"
VERSION_NEW=$(mvn org.apache.maven.plugins:maven-help-plugin:3.1.0:evaluate -Dexpression=project.version -q -DforceStdout)

echo "next release version is $VERSION_NEW" 
git add pom.xml
echo "added pom.xml file to develop"
git commit -m "Updated snapshot with latest version for next release $VERSION_NEW" 