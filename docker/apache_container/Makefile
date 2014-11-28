prepare:
	git -C ../../ archive --format tar.gz --output $$PWD/latest_Tbro.tar.gz latest ./build.properties.example  ./build.xml  ./db  ./INSTALLATION  ./jmeter_tests  ./nbproject  ./src

build: prepare
	docker build --tag tbro_apache .
run: build
	docker run -d --link Chado_DB_4_TBro:CHADO --link Worker_DB_4_TBro:WORKER --name "TBro" -p 8090:80 tbro_apache
	docker exec -i -t TBro /home/tbro/build_installation.sh
