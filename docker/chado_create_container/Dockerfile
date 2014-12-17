     FROM ubuntu
     RUN apt-get update
     RUN apt-get --assume-yes install \
         php5-cli \
         php-pear \
         php5-pgsql \
         php5-curl \
         php5-dev \
         build-essential
     RUN pear channel-discover pear.phing.info
     RUN pear install --alldeps phing/phing
     RUN pear channel-discover pear.propelorm.org
     RUN pear install -a propel/propel_runtime
     RUN pear install Log
     RUN pear install Console_CommandLine
     #RUN pear install Console_Table
     RUN pear install channel://pear.php.net/Console_ProgressBar-0.5.2beta
     RUN sed -i '/phar.readonly = /s/^.*/phar.readonly = Off/' /etc/php5/cli/php.ini
     RUN apt-get install --assume-yes \
         libdbi-perl \
         libdbd-pg-perl \
         libmodule-build-perl \
         libclass-dbi-perl \
         libclass-dbi-pg-perl \
         libclass-dbi-pager-perl \
         libxml-simple-perl \
         libtemplate-perl \
         liblog-log4perl-perl \
         libxml-dom-perl \
         libxml-writer-perl \
         libgraph-perl \
         libdbix-dbstag-perl \
         libxml-libxslt-perl \
         libima-dbi-perl \
         libclass-methodmaker-perl \
         liburi-perl \
         libxml-twig-perl \
         libfile-nfslock-perl \
         libclass-data-inheritable-perl \
         xsltproc \
         postgresql-server-dev-all \
         postgresql-client-9.3 \
         libgo-perl \
         wget
     RUN PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'force install SQL::Translator'
     RUN PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'force install URI::Escape'
     RUN PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'force install Pod::Usage'
     RUN PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'force install Config::General'
     RUN PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'force install Digest::MD5'
     RUN PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'force install Class::DBI::View'
     #RUN PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'force install LWP'
     RUN PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'force install XML::Parser::PerlSAX'
     #RUN PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'force install File::Path'
     #RUN PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'force install Text::Tabs'
     #RUN PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'force install File::Spec'
     RUN PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'force install GO::Parser'
     RUN PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'force install LWP::Simple'
     RUN PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'force install Tie::UrlEncoder'
     RUN PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'force install HTML::TreeBuilder'
     #RUN PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'force install Time::HiRes'
     RUN PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'force install IO::Dir'
     #RUN PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'force install Text::Wrap'
     RUN PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'force install DBD::Pg'
     RUN PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'force install GO::Utils'
     RUN PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'force install Bio::Root::Version'
     RUN PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'force install Bio::Chado::Schema'
     ADD generate_db.sh /tmp/
     CMD export HOME=/tmp/; \
         echo "$CHADO_PORT_5432_TCP_ADDR:$CHADO_PORT_5432_TCP_PORT:$CHADO_ENV_DB_NAME:$CHADO_ENV_DB_USER:$CHADO_ENV_DB_PW" > $HOME/.pgpass; \
         chmod 600 $HOME/.pgpass; \
         export PGPASSWORD="$CHADO_ENV_DB_PW"; \
         $HOME/generate_db.sh
