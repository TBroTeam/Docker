FROM tbroteam/tbro_apache

RUN git clone https://github.com/TBroTeam/DemoData /home/tbro/DemoData

CMD cd /home/tbro; ./build_installation.sh; cd /home/tbro/DemoData/canabis_sativa_demo/; bash ./import_demo_data.sh;
