#!/bin/bash

set -e

source ./jenkins_version.sh

echo "TAG: $VERSION"

cd gpf
git tag -a v$VERSION -m v$VERSION
git push --tags
cd -

cd gpfjs
git tag -a v$VERSION -m v$VERSION
git push --tags
cd -
