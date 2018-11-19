#!/bin/sh

uname -a
ls -ltra
pwd
set -e -u -x

git clone concourse-web updated-concourse-web
cd updated-concourse-web
set -e -u +x

ls -ltr ../.m2

mvn -Dmaven.repo.local="../.m2" clean install -Dmaven.test.skip=true

VERSION=$(mvn org.apache.maven.plugins:maven-help-plugin:3.1.0:evaluate -Dexpression=project.version -q -DforceStdout)

git config --global user.email "satishkumar_andey@comcast.com"
git config --global user.name "sandey080"

git pull origin develop
echo "Creating tag for the for new checkins in develop branch"
git tag -f -a $VERSION -m "Created tag $VERSION for the new checkins in develop"
git push origin $VERSION


echo "pulling new develop changes last time"
git pull origin develop
echo "Build success and released the SNAPSHOT version $VERSION"

ls -ltra target/*

cp target/concourseweb*.jar ../artifactory-repository/concourse-web-$VERSION.jar
echo $VERSION >> ../version/number


set -e -u -x

echo "build success np"
