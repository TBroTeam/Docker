#!/bin/bash
     export CHADO_DB_NAME=${CHADO_ENV_DB_NAME:-chado}
     export CHADO_DB_USERNAME=${CHADO_ENV_DB_USER:-tbro}
     export CHADO_DB_PASSWORD=${CHADO_ENV_DB_PW:-tbro}
     export CHADO_DB_HOST=${CHADO_PORT_5432_TCP_ADDR:-localhost}
     export CHADO_DB_PORT=${CHADO_PORT_5432_TCP_PORT:-5432}

     # download chado package
     date +"[%Y-%m-%d %H:%M:%S] Starting download of chado package..."
     wget -O /tmp/chado-1.2.tar.gz 'http://downloads.sourceforge.net/project/gmod/gmod/chado-1.2/chado-1.2.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fgmod%2Ffiles%2Fgmod%2Fchado-1.2%2F&ts=1415403627&use_mirror=kent'
     date +"[%Y-%m-%d %H:%M:%S] Finished download of chado package!"

     # Follow the instructions of Lenz to generate an adapted version of chado
     # untar the chado archive
     date +"[%Y-%m-%d %H:%M:%S] Starting preparation of chado package..."
     cd /tmp/
     tar xzf chado-1.2.tar.gz

     # change to newly created folder
     cd chado-1.2

     # follow the instructions of Lenz:
     cd modules
     perl bin/makedep.pl --modules general,cv,pub,organism,sequence,contact,companalysis,mage > default_schema.sql
     date +"[%Y-%m-%d %H:%M:%S] Finished preparation of chado package!"

     date +"[%Y-%m-%d %H:%M:%S] Started preparation of GO 1.2..."
     cd /tmp

     wget -O gene_ontology.1_2.obo 'http://www.geneontology.org/ontology/obo_format_1_2/gene_ontology.1_2.obo'

     # convertion into xml format this might need the installation of
     # additional packages and should be moved into the chade database
     # generation later
     go2fmt -p obo_text -w xml gene_ontology.1_2.obo | go-apply-xslt oboxml_to_chadoxml - > g_o.1_2.chadoxml
     date +"[%Y-%m-%d %H:%M:%S] Finished preparation of GO 1.2!"


     mkdir -p /usr/local/gmod
     export GMOD_ROOT=/usr/local/gmod

     cd /tmp/chado-1.2/

     # remove old build.conf if existing
     if [ -e build.conf ]
     then
         rm build.conf
     fi

     # run the Makefile.PL generator
     echo "" | perl Makefile.PL

     # the installation name for stag-storenode does not end by an .pl
     # to circumstand the wrong name I am generating links with the expected names
     ln -s $(which stag-storenode) $(dirname $(which stag-storenode))/stag-storenode.pl
     ln -s $(which go2fmt) $(dirname $(which go2fmt))/go2fmt.pl


     # run the make commands
     make
     make install
     make load_schema
     make prepdb

     # install the prepared GO 1.2
     date +"[%Y-%m-%d %H:%M:%S] Starting import of own GO 1.2"
     stag-storenode.pl \
         -d 'dbi:Pg:dbname='$CHADO_DB_NAME';host='$CHADO_DB_HOST';port='$CHADO_DB_PORT \
         --user "$CHADO_DB_USERNAME" \
         --password "$CHADO_DB_PASSWORD" \
         ../g_o.1_2.chadoxml
     date +"[%Y-%m-%d %H:%M:%S] Finished import of own GO 1.2"

     # importing the function ontology as last ontology
     make ontologies <<EOF
     1,2,4
     EOF

     # make the optional targets
     make rm_locks
     make clean
