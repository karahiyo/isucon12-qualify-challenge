#!/bin/sh

set -ex
cd `dirname $0`

tenantdbs="../../initial_data/*.db"
for tenantdb in $tenantdbs; do
  echo "running... sqlite3 $tenantdb < ./tenant/01_additional_bootstrap.sql"
  sqlite3 $tenantdb < ./tenant/01_additional_bootstrap.sql &
  echo "finish! tenantdb: $tenantdb"
done
wait
