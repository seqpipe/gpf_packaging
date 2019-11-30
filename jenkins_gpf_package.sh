#!/bin/bash

set -e

source ./jenkins_version.sh

echo "version: ${VERSION}"

tar zcvf gpf-${PY_BRANCH}-${JS_BRANCH}-${VERSION}.tar.gz gpf/

