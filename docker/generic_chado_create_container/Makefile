prepare:

build: prepare
	docker build --tag tbro_generic_chado_generate .
run:
	docker run -i -t --link Chado_DB_4_TBro:CHADO --name "Generic_CHADO" tbro_generic_chado_generate
