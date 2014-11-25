none:
	echo "Nothing to do"

.PHONY: del_container del_images
del_container:
	docker rm -f Worker_FTP_4_TBro TBro-Worker TBro Worker_DB_4_TBro Chado_DB_4_TBro Generic_CHADO
del_images: del_container
	docker rmi tbro_demo tbro_worker_ftp tbro_worker tbro_chado_generate tbro_apache greatfireball/generic_postgres_db  tbro_generic_chado_generate generic_chado_db_reload
