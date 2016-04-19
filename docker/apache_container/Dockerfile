FROM ubuntu

RUN apt-get update && apt-get --assume-yes install \
    apache2 \
    build-essential \
    git \
    memcached \
    php5 \
    php-pear \
    php5-curl \
    php5-dev \
    php5-memcache \
    php5-pgsql \
    postgresql-client \
    postgresql-client-common \
    bash-completion

RUN curl https://getcomposer.org/download/1.0.1/composer.phar >/usr/bin/composer
RUN chmod +x /usr/bin/composer
RUN export PATH=~/.composer/vendor/bin:$PATH
RUN echo 'export PATH=~/.composer/vendor/bin:$PATH' >>~/.bash_profile
RUN composer global require phing/phing
RUN composer global require propel/propel @dev

RUN pear install Log
RUN pear install Console_CommandLine
#RUN pear install Console_Table
RUN pear install channel://pear.php.net/Console_ProgressBar-0.5.2beta

RUN sed -i '/phar.readonly = /s/^.*/phar.readonly = Off/' /etc/php5/cli/php.ini

RUN a2enmod rewrite

RUN git clone --recursive https://github.com/TBroTeam/TBro.git /tmp/tbro && cd /tmp/tbro && git checkout master
RUN mkdir -p /home/tbro/
RUN cp -r /tmp/tbro/* /home/tbro/

ADD build_installation.sh /home/tbro/
ADD update_installation.sh /home/tbro/
ADD enable_AllowOverride_Apache2.sed /home/tbro/

RUN sed -i -f /home/tbro/enable_AllowOverride_Apache2.sed /etc/apache2/apache2.conf

CMD service memcached restart; service apache2 start; /home/tbro/update_installation.sh; while true; do sleep 60; done
