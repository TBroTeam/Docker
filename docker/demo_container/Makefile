prepare:
	git archive --format tar.gz --output latest_demo-set.tar.gz latest ../../doc/tutorial/cannabis_sativa_demo

build:
	docker build --tag tbro_demo .
run:
	docker run --rm -i -t --link Worker_DB_4_TBro:WORKER --link Chado_DB_4_TBro:CHADO --name "TBro-Demo" tbro_demo
