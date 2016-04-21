#!/bin/bash
if [ ! -e /home/tbro ]
then
    echo "No /home/tbro directory found... Exiting!"
    exit
fi

cd /home/tbro

# check if the build.properties are existing, otherwise we are done
if [ ! -e build.properties ]
then
    echo "No build.properties found... Exiting!"
    exit
fi

# load the build.properties
eval $(grep "prefix =" build.properties | tr -d " ")
eval $(grep "config_dir =" build.properties | tr -d " ")

# check if the file $config_dir/config.php exists, otherwise exit
if [ ! -e $config_dir/config.php ]
then
    echo "No $config_dir/config.php found... Exiting!"
    exit
fi

# finally use the values from environmental variables to update
# database connection parameters
echo "s/\(^define('DB_CONNSTR', 'pgsql:host=\).*\(;dbname=\).*\(;port=\).*\(');\).*/\1"$CHADO_PORT_5432_TCP_ADDR"\2"$CHADO_ENV_DB_NAME"\3"$CHADO_PORT_5432_TCP_PORT"\4/;
     s/\(^define('DB_USERNAME', '\).*\(');\)/\1"$CHADO_ENV_DB_USER"\2/;
     s/\(^define('DB_PASSWORD', '\).*\(');\)/\1"$CHADO_ENV_DB_PW"\2/;
     s/\(^define('QUEUE_DB_CONNSTR', 'pgsql:host=\).*\(;dbname=\).*\(;port=\).*\(');\).*/\1"$WORKER_PORT_5432_TCP_ADDR"\2"$WORKER_ENV_DB_NAME"\3"$WORKER_PORT_5432_TCP_PORT"\4/;
     s/\(^define('QUEUE_DB_USERNAME', '\).*\(');\)/\1"$WORKER_ENV_DB_USER"\2/;
     s/\(^define('QUEUE_DB_PASSWORD', '\).*\(');\)/\1"$WORKER_ENV_DB_PW"\2/;" > update_config.sed

sed -i -f update_config.sed $config_dir/config.php

# Finally I have to restart the apache
service apache2 restart
