#!/bin/sh

set -ex
cd `dirname $0`

# SQLiteのデータベースを初期化
rm -f ../tenant_db/*.db
cp -r ../../initial_data/*.db ../tenant_db/

#ssh -o "StrictHostKeyChecking=no" webapp1 \
#  sh -c "rm -f webapp/tenant_db/*.db && cp -r initial_data/*.db webapp/tenant_db/" &
#ssh -o "StrictHostKeyChecking=no" webapp2 \
#  sh -c "rm -f webapp/tenant_db/*.db && cp -r initial_data/*.db webapp/tenant_db/" &
#wait
