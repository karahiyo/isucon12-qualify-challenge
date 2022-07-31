bench:
	docker compose run bench ./bench

install-tools:
	brew install alp
	brew install percona-toolkit

reload-all:
	docker compose down
	docker compose up --build -d

slow-on:
	docker compose exec mysql mysql -uroot -proot -e "set global slow_query_log_file = '/tmp/mysql-slow.log'; set global long_query_time = 0.001; set global slow_query_log = ON;"

slow-off:
	docker compose exec mysql mysql -uroot -proot -e "set global slow_query_log = OFF;"

pt-query-digest:
	docker compose cp mysql:/tmp/mysql-slow.log /tmp/mysql-slow.log | pt-query-digest /tmp/mysql-slow.log

ALPM="/api/player/competition/.+/ranking,/api/admin/tenants/billing,/api/organizer/players/add,/api/player/player/.+,/api/organizer/competition/.+/score,/api/organizer/competition/.+/finish,/api/organizer/player/.+/disqualified,/js,/css,/api/me"
OUTFORMAT=count,2xx,3xx,4xx,5xx,method,uri,min,max,sum,avg,p99
NGINX_LOG_LENGTH=10000
.PHONY: alp
alp:
	docker compose logs nginx --tail $(NGINX_LOG_LENGTH) --no-log-prefix | \
		alp ltsv --sort sum --reverse -o $(OUTFORMAT) -m $(ALPM)


