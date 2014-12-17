     FROM ubuntu
     RUN apt-get update
     RUN apt-get --assume-yes install \
         vsftpd
     EXPOSE 21
     RUN mkdir -p /var/run/vsftpd/empty
     RUN echo "listen=YES\nanonymous_enable=yes\nlocal_enable=YES\nanon_root=/home/tbro\nlocal_umask=033\nwrite_enable=YES\ndirmessage_enable=YES\nuse_localtime=YES\nxferlog_enable=YES\nconnect_from_port_20=YES\nsecure_chroot_dir=/var/run/vsftpd/empty\npam_service_name=vsftpd\nrsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem\nrsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key" > /etc/vsftpd.conf
     CMD export FTP_USER=${FTP_USER:-ftpuser}; export FTP_PW=${FTP_PW:-ftppassword}; adduser "$FTP_USER"; echo "$FTP_USER":"$FTP_PW" | chpasswd; while true; do vsftpd; done
