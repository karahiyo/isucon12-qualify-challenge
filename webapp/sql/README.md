isucon12-qualify-challenge/webapp/sql
======================================

## Tips:

### 初期化手順

##### 1. tenantdbの初期化

- index作成
- player_scoreのminify
 
```shell
sh update_tenantdb_initial_data.sh
```

##### 2. admindb visit_history2テーブルの作成、初期化、(~~initializeごとの初期化のための準備~~正しくないけどアプリの使用上問題ないからやらない)

visit_history2テーブルの作成、初期化
```shell
mysql -u"$ISUCON_DB_USER" \
-p"$ISUCON_DB_PASSWORD" \
--host "$ISUCON_DB_HOST" \
--port "$ISUCON_DB_PORT" \
"$ISUCON_DB_NAME" < sql/admin/101_visit_history2.sql
```

```shell
mysqldump -u"root" -p"root" --host "$ISUCON_DB_HOST" --port "$ISUCON_DB_PORT" "$ISUCON_DB_NAME" visit_history2 --no-create-info --single-transaction > ../../initial_data/visit_history2.dump
```
