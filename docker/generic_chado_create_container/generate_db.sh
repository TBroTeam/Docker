#!/bin/bash
export CHADO_DB_NAME=${CHADO_ENV_DB_NAME:-chado}
export CHADO_DB_USERNAME=${CHADO_ENV_DB_USER:-tbro}
export CHADO_DB_PASSWORD=${CHADO_ENV_DB_PW:-tbro}
export CHADO_DB_HOST=${CHADO_PORT_5432_TCP_ADDR:-localhost}
export CHADO_DB_PORT=${CHADO_PORT_5432_TCP_PORT:-5432}

# download chado package
date +"[%Y-%m-%d %H:%M:%S] Starting download of chado package..."
wget -O /tmp/chado-1.31.tar.gz 'http://sourceforge.net/projects/gmod/files/gmod/chado-1.31/chado-1.31.tar.gz/download'

cd /tmp/
tar xzf /tmp/chado-1.31.tar.gz

date +"[%Y-%m-%d %H:%M:%S] Finished download of chado package!"

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

cd /tmp/chado-1.31/

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

# importing the function ontology as last ontology
make ontologies <<EOF
1,2,4,5
EOF

# install the prepared GO 1.2
date +"[%Y-%m-%d %H:%M:%S] Starting import of own GO 1.2"
stag-storenode.pl \
    -d 'dbi:Pg:dbname='$CHADO_DB_NAME';host='$CHADO_DB_HOST';port='$CHADO_DB_PORT \
    --user "$CHADO_DB_USERNAME" \
    --password "$CHADO_DB_PASSWORD" \
    ../g_o.1_2.chadoxml

if [ $? -ne 0 ]
then
    date +"[%Y-%m-%d %H:%M:%S] Import of GO 1.2 failed, retrying"
    stag-storenode.pl \
        -d 'dbi:Pg:dbname='$CHADO_DB_NAME';host='$CHADO_DB_HOST';port='$CHADO_DB_PORT \
        --user "$CHADO_DB_USERNAME" \
        --password "$CHADO_DB_PASSWORD" \
        ../g_o.1_2.chadoxml

fi
date +"[%Y-%m-%d %H:%M:%S] Finished import of own GO 1.2"

# make the optional targets
make rm_locks
make clean
