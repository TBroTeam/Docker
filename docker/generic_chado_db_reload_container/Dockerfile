 FROM ubuntu

 RUN apt-get update
 RUN apt-get --assume-yes install \
     postgresql-client-common \
     postgresql-client-9.3

ADD 2014-11-24_chado_database_complete_GO1.2.sql.tar.gz /tmp/
CMD export PGPASSWORD="$CHADO_ENV_DB_PW"; \
    cat /tmp/2014-11-24_chado_database_complete_GO1.2.sql | psql --host=$CHADO_PORT_5432_TCP_ADDR --port=$CHADO_PORT_5432_TCP_PORT --username=$CHADO_ENV_DB_USER $CHADO_ENV_DB_NAME
