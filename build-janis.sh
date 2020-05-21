#!/bin/bash
set -e

JANIS_DIR=${JANIS_DIR:-/janis}
cd ${JANIS_DIR}

JANIS_ALL_MODULES="janis-core janis-unix janis-bioinformatics janis-pipelines janis-templates janis-assistant"
JANIS_BUILD_MODULES=${JANIS_BUILD_MODULES:-$JANIS_ALL_MODULES}

for m in ${JANIS_BUILD_MODULES}
do
    ( cd ${m} && python3 setup.py install )
done
