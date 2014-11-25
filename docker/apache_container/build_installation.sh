#!/bin/bash
     echo "
     prefix = $PREFIX
     config_dir = \${prefix}/etc/tbro
     bin_dir = \${prefix}/bin
     www_root = \${prefix}/var/www/html
     share_path = \${prefix}/share/tbro
     var_path = \${prefix}/var/tbro
     autocomplete_path = /etc/bash_completion.d
     www_user = www-data
     www_group = www-data
     www_mode = 0777

     chado_db_host = $CHADO_PORT_5432_TCP_ADDR
     chado_db_name = $CHADO_ENV_DB_NAME
     chado_db_port = $CHADO_PORT_5432_TCP_PORT
     chado_db_username = $CHADO_ENV_DB_USER
     chado_db_password = $CHADO_ENV_DB_PW

     queue_db_host = $WORKER_PORT_5432_TCP_ADDR
     queue_db_name = $WORKER_ENV_DB_NAME
     queue_db_port = $WORKER_PORT_5432_TCP_PORT
     queue_db_username = $WORKER_ENV_DB_USER
     queue_db_password = $WORKER_ENV_DB_PW

     srcdir = \${project.basedir}/src
     builddir = /tmp/build/tbro" > /home/tbro/build.properties

     cd /home/tbro

     # get the config dir from build.properties
     eval $(grep "prefix =" build.properties | tr -d " ")
     eval $(grep "config_dir =" build.properties | tr -d " ")
     eval $(grep "www_root =" build.properties | tr -d " ")

     phing database-initialize

     # rename config.php.generated cvterms.php.generated
     mv $config_dir/config.php.generated $config_dir/config.php
     mv $config_dir/cvterms.php.generated $config_dir/cvterms.php

     phing database-commit-modifications

     phing cli-install
     phing web-install
     phing queue-install-db

     if [ -e $www_root/index.html ]
     then
         rm $www_root/index.html
     fi
