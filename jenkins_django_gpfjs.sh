#!/bin/bash

set -e

source ./jenkins_version.sh

rm -rf gpf/wdae/wdae/gpfjs
cp -r django_gpfjs gpf/wdae/wdae/gpfjs

tar zxvf gpfjs-dist-gpfjs.tar.gz -C gpf/wdae/wdae/gpfjs/static/gpfjs/

cd gpf/wdae/wdae

sed -i \
    s/"urlpatterns = \[.*$"/"urlpatterns = \[ url(r'\^\$', index), url(r'\^gpfjs\/\.\*\$', index),"/g \
    wdae/urls.py

sed -i \
    s/"# gpfjs.*$"/"from gpfjs.views import index"/g \
    wdae/urls.py

sed -i \
    s/"\s*# 'gpfjs.*$"/"    'gpfjs',"/g \
    wdae/default_settings.py

sed -i \
    s/"\s*'NAME': 'wdae.sql',"/"'NAME': os.path.join(os.environ.get('DAE_DB_DIR'), 'wdae\/wdae.sql'),"/g \
    wdae/default_settings.py

sed -i \
    s/"\s*'filename': 'wdae-api.log',"/"'filename': os.path.join(os.environ.get('DAE_DB_DIR'), 'wdae\/wdae-api.log'),"/g \
    wdae/default_settings.py

sed -i \
    s/"\s*'filename': 'wdae-debug.log',"/"'filename': os.path.join(os.environ.get('DAE_DB_DIR'), 'wdae\/wdae-debug.log'),"/g \
    wdae/default_settings.py

sed -i \
    s/"\s*'LOCATION': 'wdae_django_default.cache',"/"'LOCATION': os.path.join(os.environ.get('DAE_DB_DIR'), 'wdae\/wdae_django_default.cache'),"/g \
    wdae/default_settings.py

sed -i \
    s/"\s*'LOCATION': 'wdae_django_pre.cache',"/"'LOCATION': os.path.join(os.environ.get('DAE_DB_DIR'), 'wdae\/wdae_django_pre.cache'),"/g \
    wdae/default_settings.py

cd -
