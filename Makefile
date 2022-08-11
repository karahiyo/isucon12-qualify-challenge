.PHONY: bench
bench: cleanlog
	docker compose exec bench ./bench

small_bench: cleanlog
	docker compose exec bench ./bench -duration 10s

BENCH_RESULT_DIR := $(CURDIR)/bench_result/$(shell date +"%Y%m%d_%H%M%S")
run_bench_and_collect_bench_result:
	$(MAKE) cleanlog
	docker compose exec bench ./bench | tee $(BENCH_RESULT_DIR)/bench.out
	$(MAKE) alp > $(BENCH_RESULT_DIR)/alp.out
	$(MAKE) sqlite-trace > $(BENCH_RESULT_DIR)/sqlite-trace.out

cleanlog:
	docker compose exec webapp cp /dev/null $(SQLITE_TRACE_LOG)
	docker compose exec mysql cp /dev/null $(MYSQL_SLOW_LOG)

__install-tools:
	brew install alp
	brew install percona-toolkit
	brew install dsq

deploy-webapp:
	docker compose up -d --no-deps --build webapp
	docker compose logs webapp -f --tail 10

start_pprof:
	go tool pprof -seconds 60 -http=0.0.0.0:16060 http://localhost:6060/debug/pprof/profile

connect-admindb:
	docker compose exec mysql mysql -uroot -proot isuports

connect-tenantdb1:
	docker compose exec webapp sqlite3 ../tenant_db/1.db

restart-all-container:
	docker compose down
	docker compose up --build -d

SQLITE_TRACE_LOG=/tmp/sqlite_trace.log
SQLITE_TRACE_LOG_LIMIT=10000
sqlite-trace:
	docker compose cp webapp:$(SQLITE_TRACE_LOG) $(SQLITE_TRACE_LOG) | \
		tail -n $(SQLITE_TRACE_LOG_LIMIT) $(SQLITE_TRACE_LOG) | \
		dsq -s jsonl "SELECT SUBSTRING(statement, 0, 1000) AS statement, COUNT(1) as cnt, AVG(query_time) as avg, SUM(query_time) as sum FROM {} GROUP BY statement ORDER BY sum DESC" | jq .

slow-on:
	docker compose exec mysql touch $(MYSQL_SLOW_LOG)
	docker compose exec mysql chmod 777 $(MYSQL_SLOW_LOG)
	docker compose exec mysql mysql -uroot -proot -e "set global slow_query_log_file = '/tmp/mysql-slow.log'; set global long_query_time = 0.001; set global slow_query_log = ON;"

slow-off:
	docker compose exec mysql mysql -uroot -proot -e "set global slow_query_log = OFF;"

MYSQL_SLOW_LOG=/tmp/mysql-slow.log
pt-query-digest:
	docker compose cp mysql:$(MYSQL_SLOW_LOG) $(MYSQL_SLOW_LOG) | pt-query-digest $(MYSQL_SLOW_LOG)

ALPM="/api/player/competition/.+/ranking,/api/admin/tenants/billing,/api/organizer/players/add,/api/player/player/.+,/api/organizer/competition/.+/score,/api/organizer/competition/.+/finish,/api/organizer/player/.+/disqualified,/js,/css,/api/me"
OUTFORMAT=count,2xx,3xx,4xx,5xx,method,uri,min,max,sum,avg,p99
NGINX_LOG_LIMIT=20000
.PHONY: alp
alp:
	docker compose logs nginx --tail $(NGINX_LOG_LIMIT) --no-log-prefix | \
		alp ltsv --sort sum --reverse -o $(OUTFORMAT) -m $(ALPM)
