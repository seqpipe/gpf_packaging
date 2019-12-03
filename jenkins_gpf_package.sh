#!/bin/bash

set -e

source ./jenkins_version.sh

echo "version: ${VERSION}"
mkdir -p ${BUILDS}

tar zcvf ${BUILDS}/${GPF_PACKAGE} \
    --exclude .git \
    gpf/
