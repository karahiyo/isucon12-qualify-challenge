.PHONY: bench
bench: cleanlog
	docker compose run bench ./bench

small_bench: cleanlog
	docker compose run bench ./bench -duration 10s

cleanlog:
	docker compose exec mysql cp /dev/null /tmp/mysql-slow.log

install-tools:
	brew install alp
	brew install percona-toolkit
	brew install dsq

restart-all-container:
	docker compose down
	docker compose up -d

SQLITE_TRACE_LOG=/tmp/sqlite_trace.log
sqlite-trace:
	docker compose cp webapp:$(SQLITE_TRACE_LOG) $(SQLITE_TRACE_LOG) | tail -n 10000 $(SQLITE_TRACE_LOG) | \
		dsq -s jsonl "SELECT statement, AVG(query_time) as avg, SUM(query_time) as sum FROM {} GROUP BY statement ORDER BY sum DESC" | jq .

slow-on:
	docker compose exec mysql mysql -uroot -proot -e "set global slow_query_log_file = '/tmp/mysql-slow.log'; set global long_query_time = 0.001; set global slow_query_log = ON;"

slow-off:
	docker compose exec mysql mysql -uroot -proot -e "set global slow_query_log = OFF;"

MYSQL_SLOW_LOG=/tmp/mysql-slow.log
pt-query-digest:
	docker compose cp mysql:$(MYSQL_SLOW_LOG) $(MYSQL_SLOW_LOG) | pt-query-digest $(MYSQL_SLOW_LOG)

ALPM="/api/player/competition/.+/ranking,/api/admin/tenants/billing,/api/organizer/players/add,/api/player/player/.+,/api/organizer/competition/.+/score,/api/organizer/competition/.+/finish,/api/organizer/player/.+/disqualified,/js,/css,/api/me"
OUTFORMAT=count,2xx,3xx,4xx,5xx,method,uri,min,max,sum,avg,p99
NGINX_LOG_LENGTH=10000
.PHONY: alp
alp:
	docker compose logs nginx --tail $(NGINX_LOG_LENGTH) --no-log-prefix | \
		alp ltsv --sort sum --reverse -o $(OUTFORMAT) -m $(ALPM)

