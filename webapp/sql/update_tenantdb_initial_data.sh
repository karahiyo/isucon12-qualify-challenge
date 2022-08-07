#!/bin/sh

set -ex
cd `dirname $0`

mkdir -p ../../initial_data/backup/
cp -r ../../initial_data/*.db ../../initial_data/backup/

tenantdbs="../../initial_data/*.db"
for tenantdb in $tenantdbs; do
  sqlite3 $tenantdb < ./tenant/01_additional_bootstrap.sql &
done
wait
