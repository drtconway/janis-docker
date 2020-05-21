#!/bin/bash
set -e

JANIS_DEFAULT_GIT_BASE="https://github.com/PMCC-BioinformaticsCore"
JANIS_DEFAULT_MODULES="janis-assistant janis-bioinformatics janis-core janis-pipelines janis-templates janis-unix"
JANIS_GIT_BASE=${JANIS_GIT_BASE:-$JANIS_DEFAULT_GIT_BASE}
JANIS_MODULES=${JANIS_MODULES:-$JANIS_DEFAULT_MODULES}

JANIS_DIR=${JANIS_DIR:-/janis}

if ! test -d ${JANIS_DIR}
then
    echo "janis directory \"${JANIS_DIR}\" doesn't exist - creating it." 1>&2
    mkdir -p ${JANIS_DIR}
fi

cd ${JANIS_DIR}

for m in ${JANIS_MODULES}
do
    if test -d ${m}
    then
        echo "janis module \"${m}\" already exists - skipping." 1>&2
        continue
    fi
    git clone ${JANIS_GIT_BASE}/${m}.git
done
