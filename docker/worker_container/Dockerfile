     FROM ubuntu
     RUN apt-get update
     RUN apt-get --assume-yes install \
         php5-cli \
         php5-pgsql \
         php5-curl \
         ncbi-blast+ \
         wget \
         curl \
         ftp
     ADD latest_worker-unix.tar.gz /home/tbro/
     ADD worker_build_installation.sh /home/tbro/
     CMD while true; do cd /home/tbro; ./worker_build_installation.sh; php ./worker.php config.php; done
