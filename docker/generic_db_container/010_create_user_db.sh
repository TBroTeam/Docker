#!/bin/bash
     # Check if the environment variables DB_* exist otherwise take default values
     DB_NAME=${DB_NAME:-mydatabase}
     DB_PW=${DB_PW:-mypassword}
     DB_USER=${DB_USER:-myuser}
     echo "******CREATING DOCKER DATABASE******"
     gosu postgres postgres --single <<- EOSQL
        CREATE DATABASE $DB_NAME;
        CREATE ROLE $DB_USER ENCRYPTED PASSWORD '$DB_PW' NOSUPERUSER CREATEDB NOCREATEROLE INHERIT LOGIN;
        ALTER DATABASE $DB_NAME OWNER TO $DB_USER;
        GRANT ALL PRIVILEGES ON DATABASE $DB_NAME to $DB_USER;
     EOSQL
     echo ""
     echo "******DOCKER DATABASE CREATED******"
