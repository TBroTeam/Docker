FROM ubuntu

RUN apt-get update
RUN apt-get --assume-yes install \
    php5-cli \
    php5-pgsql \
    php5-curl \
    ncbi-blast+ \
    wget \
    curl \
    ftp \
    git

RUN mkdir -p /home/tbro
RUN cd /tmp && git clone https://github.com/TBroTeam/TBro.git
RUN cd /tmp/TBro && git checkout master && cp -r src/queue/worker-php/* /home/tbro/

ADD worker_build_installation.sh /home/tbro/

CMD while true; do cd /home/tbro; ./worker_build_installation.sh; php ./worker.php config.php; done
