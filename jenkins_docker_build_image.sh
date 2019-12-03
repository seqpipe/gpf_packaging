#!/bin/bash

set -e

source ./jenkins_version.sh

cp ${BUILDS}/${GPF_PACKAGE} ${WD}
tar xzvf ${BUILDS}/${GPF_PACKAGE} \
    gpf/conda-environment.yml \
    --strip-components=1

docker build -t "${GPF_DEV_DOCKER_IMAGE}" .

rm -f ${WD}/${GPF_PACKAGE}
