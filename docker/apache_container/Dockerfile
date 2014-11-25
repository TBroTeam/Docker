     FROM ubuntu

     RUN apt-get update
     RUN apt-get --assume-yes install \
         apache2 \
         php5 \
         php-pear \
         php5-pgsql \
         php5-curl \
         php5-dev \
         build-essential \
         memcached \
         php5-memcache \
         postgresql-client-common \
         postgresql-client-9.3

     RUN pear channel-discover pear.phing.info
     RUN pear install --alldeps phing/phing
     RUN pear channel-discover pear.propelorm.org
     RUN pear install -a propel/propel_runtime-1.6.8
     RUN pear install Log
     RUN pear install Console_CommandLine
     #RUN pear install Console_Table
     RUN pear install channel://pear.php.net/Console_ProgressBar-0.5.2beta

     RUN sed -i '/phar.readonly = /s/^.*/phar.readonly = Off/' /etc/php5/cli/php.ini

     RUN a2enmod rewrite

     ADD latest_Tbro.tar.gz /home/tbro/

     ADD build_installation.sh /home/tbro/
     ADD update_installation.sh /home/tbro/
     ADD enable_AllowOverride_Apache2.sed /home/tbro/

     RUN sed -i -f /home/tbro/enable_AllowOverride_Apache2.sed /etc/apache2/apache2.conf

     CMD service memcached restart; service apache2 start; /home/tbro/update_installation.sh; while true; do sleep 60; done
