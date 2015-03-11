prepare:
	git -C ../../src/queue/worker-php archive --format tar.gz --output $$PWD/latest_worker-unix.tar.gz latest .

build: prepare
	docker build --tag tbro_worker .
run:
	docker run -d --link Worker_DB_4_TBro:WORKER --link Worker_FTP_4_TBro:WORKERFTP --name "TBro-Worker" tbro_worker
	docker exec -i -t TBro /home/tbro/worker_build_installation.sh
