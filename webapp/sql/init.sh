#!/bin/sh

set -ex
cd `dirname $0`

ISUCON_DB_HOST=${ISUCON_DB_HOST:-127.0.0.1}
ISUCON_DB_PORT=${ISUCON_DB_PORT:-3306}
ISUCON_DB_USER=${ISUCON_DB_USER:-isucon}
ISUCON_DB_PASSWORD=${ISUCON_DB_PASSWORD:-isucon}
ISUCON_DB_ROOT_USER=${ISUCON_DB_USER:-root}
ISUCON_DB_ROOT_PASSWORD=${ISUCON_DB_PASSWORD:-root}
ISUCON_DB_NAME=${ISUCON_DB_NAME:-isuports}

# MySQLを初期化
mysql -u"$ISUCON_DB_USER" \
		-p"$ISUCON_DB_PASSWORD" \
		--host "$ISUCON_DB_HOST" \
		--port "$ISUCON_DB_PORT" \
		"$ISUCON_DB_NAME" < init.sql

# visit_hository2のrestore
# mysqldump -u"$ISUCON_DB_ROOT_USER" -p"$ISUCON_DB_ROOT_PASSWORD" --host "$ISUCON_DB_HOST" --port "$ISUCON_DB_PORT" "$ISUCON_DB_NAME" visit_history2 --no-create-info --single-transaction --set-gtid-purged=OFF > ../../initial_data/visit_history2.dump
#
#mysqlimport -u"$ISUCON_DB_ROOT_USER" \
#		-p"$ISUCON_DB_ROOT_PASSWORD" \
#		--host "$ISUCON_DB_HOST" \
#		--port "$ISUCON_DB_PORT" \
#		"$ISUCON_DB_NAME" ../../initial_data/visit_history2.dump

# SQLiteのデータベースを初期化
rm -f ../tenant_db/*.db
cp -r ../../initial_data/*.db ../tenant_db/

# 事前にupdate_tenantdb_initial_data.shで実行する。ここでのupdateはしない
# sh ./update_tenantdb_initial_data.sh
