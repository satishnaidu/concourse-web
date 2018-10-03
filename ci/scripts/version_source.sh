#!/bin/bash

set -eux

git clone location-service updated-location-service

cd updated-location-service

version=`cat ../version/number`

git tag location-service-v$version.build
