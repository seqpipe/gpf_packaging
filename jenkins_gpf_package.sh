#!/bin/bash

set -e

source ./jenkins_version.sh

echo "version: ${VERSION}"
mkdir -p ${BUILDS}

tar zcvf ${BUILDS}/${GPF_PACKAGE} \
    --exclude .git \
    --exclude gpf_remote \
    --exclude *.vscode* \
    --exclude *comp-data* \
    --exclude *__pycache__* \
    --exclude *.pytest_cache* \
    --exclude *.snakemake* \
    --exclude *.mypy_cache* \
    --exclude gpf/genotype-iossifov_2014-latest.tar.gz \
    --exclude *.bak*\
    gpf/

mv gpfjs-dist-gpfjs.tar.gz ${BUILDS}/${GPFJS_PACKAGE}
