prepare:

build: prepare
	docker build --tag tbro_chado_generate .
run: build
	docker run -i -t --rm --link Chado_DB_4_TBro:CHADO --name "TBro_CHADO" tbro_chado_generate
