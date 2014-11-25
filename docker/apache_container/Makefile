prepare:
	git archive --format tar.gz --output latest_Tbro.tar.gz latest ../../

build:
	docker build --tag tbro_apache .
run:
	docker run -d --link Chado_DB_4_TBro:CHADO --link Worker_DB_4_TBro:WORKER --name "TBro" -p 8090:80 tbro_apache
	docker exec -i -t TBro /home/tbro/build_installation.sh
