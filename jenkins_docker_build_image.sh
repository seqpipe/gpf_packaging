#!/bin/bash

set -e

source ./jenkins_version.sh

cp ${BUILDS}/${GPF_PACKAGE} ${WD}

docker build -t "${GPF_DEV_DOCKER_IMAGE}" .

rm -f ${WD}/${GPF_PACKAGE}
