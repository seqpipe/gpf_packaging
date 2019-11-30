#!/bin/bash

set -e

source ./jenkins_version.sh

echo "version: ${VERSION}"
mkdir -p builds

tar zcvf builds/${GPF_PACKAGE} \
    --exclude .git \
    gpf/
