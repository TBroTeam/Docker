FROM ubuntu

RUN apt-get update && apt-get --assume-yes install \
    curl \
    ftp \
    git \
    ncbi-blast+ \
    php5-cli \
    php5-curl \
    php5-pgsql \
    wget

RUN mkdir -p /home/tbro
RUN cd /tmp && git clone https://github.com/TBroTeam/TBro.git
RUN cd /tmp/TBro && git checkout master && cp -r src/queue/worker-php/* /home/tbro/

ADD worker_build_installation.sh /home/tbro/

CMD while true; do cd /home/tbro; ./worker_build_installation.sh; php ./worker.php config.php; done
