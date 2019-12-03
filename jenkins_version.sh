#!/bin/bash

set -e

if [ -z $WD ]; then
    export WD=$(pwd)
fi

echo "WD=$WD"

export BUILDS=${WD}/builds
mkdir -p ${BUILDS}
echo "BUILDS=${BUILDS}"

export DATA=${WD}/data
mkdir -p ${DATA}
echo "DATA=${DATA}"


echo "GPF_BRANCH=${GPF_BRANCH}"
echo "GPFJS_BRANCH=${GPFJS_BRANCH}"

echo "GPF_VERSION=${GPF_VERSION}"

export PY_BRANCH=${GPF_BRANCH:-}
if [ -z $PY_BRANCH ]; then
    export PY_BRANCH=master
fi

export JS_BRANCH=${GPFJS_BRANCH:-}
if [ -z $JS_BRANCH ]; then
    export JS_BRANCH=master
fi

export VERSION=${GPF_VERSION:-}
if [ -z $VERSION ]; then
    export VERSION=3.0.0dev
fi

export BUILD=${BUILD_NUMBER:-}
if [ -z $BUILD ]; then
    export BUILD=1
fi

export VERSION=$VERSION$BUILD

echo "VERSION: ${VERSION}"

export GPF_PACKAGE="gpf-${PY_BRANCH}-${JS_BRANCH}-${VERSION}.tar.gz"
export GPF_DEV_DOCKER_IMAGE="seqpipe/gpf_dev_${PY_BRANCH}_${JS_BRANCH}:${BUILD}"

