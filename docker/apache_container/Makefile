prepare:
	git clone https://github.com/TBroTeam/TBro latest_Tbro
	tar -czf $$PWD/latest_Tbro.tar.gz latest_Tbro

build: prepare
	docker build --tag tbro_apache .
run: build
	docker run -d --link Chado_DB_4_TBro:CHADO --link Worker_DB_4_TBro:WORKER --name "TBro" -p 8090:80 tbro_apache
	docker exec -i -t TBro /home/tbro/build_installation.sh
