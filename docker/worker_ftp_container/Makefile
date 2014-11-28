prepare:

build: prepare
	docker build --tag tbro_worker_ftp .
run: build
	docker run -d --name "Worker_FTP_4_TBro" tbro_worker_ftp
