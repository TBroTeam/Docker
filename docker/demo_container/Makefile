prepare:
	git clone https://github.com/TBroTeam/DemoData
	tar czf $$PWD/latest_demo-set.tar.gz DemoData/cannabis_sativa_demo

build: prepare
	docker build --tag tbro_demo .
run:
	docker run --rm -i -t --link Worker_DB_4_TBro:WORKER --link Chado_DB_4_TBro:CHADO --name "TBro-Demo" tbro_demo
