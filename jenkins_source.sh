#!/bin/bash

set -e

source ./jenkins_version.sh

echo "PY_BRANCH=$PY_BRANCH"
echo "JS_BRANCH=$JS_BRANCH"

if [ ! -d 'gpf' ];
then
    git clone git@github.com:iossifovlab/gpf.git
fi

cd gpf

# clean previous gpfjs build
rm -rf wdae/wdae/gpfjs/

git pull
git checkout -f ${PY_BRANCH}
git pull

cd -


if [ ! -d 'gpfjs' ];
then
    git clone git@github.com:iossifovlab/gpfjs.git
fi

cd gpfjs

git pull
git checkout -f ${JS_BRANCH}
git pull

cd -
