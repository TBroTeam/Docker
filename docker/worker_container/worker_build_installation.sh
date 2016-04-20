#!/bin/bash
cd /home/tbro

# set the correct connection parameter
sed -i 's/\${queue_db_host}/'WORKER'/' config.php
sed -i 's/\${queue_db_name}/'$WORKER_ENV_DB_NAME'/' config.php
sed -i 's/\${queue_db_port}/'$WORKER_PORT_5432_TCP_PORT'/' config.php

# set the correct user parameter
sed -i 's/\${queue_db_username}/'$WORKER_ENV_DB_USER'/' config.php
sed -i 's/\${queue_db_password}/'$WORKER_ENV_DB_PW'/' config.php
