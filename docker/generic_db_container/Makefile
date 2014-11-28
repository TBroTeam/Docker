prepare:

build: prepare
	docker build --tag "greatfireball/generic_postgres_db" .
run: build
	docker run -d -e DB_NAME=chado -e DB_USER=tbro -e DB_PW=tbro --name "Chado_DB_4_TBro" greatfireball/generic_postgres_db
	docker run -d -e DB_NAME=worker -e DB_USER=worker -e DB_PW=worker --name "Worker_DB_4_TBro" greatfireball/generic_postgres_db
