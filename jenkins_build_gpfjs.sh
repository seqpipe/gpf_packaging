#!/bin/bash

set -e

cd gpfjs

rm -rf node_modules package-lock.json
npm install

rm -rf dist
ng build --prod --aot --configuration 'production' --base-href '/gpfjs/' --deploy-url '/static/gpfjs/'

python ppindex.py

cd dist/gpfjs && tar zcvf ../../../gpfjs-dist-gpfjs.tar.gz . && cd -

cd -

