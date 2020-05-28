FROM drtomc/janis-build

RUN pip3 install cwltool && \
    /clone-janis.sh && \
    rm /clone-janis.sh && \
    /build-janis.sh && \
    rm /build-janis.sh && \
    rm -rf janis && \
    mkdir /singularity && \
    janis init --ensure-cromwell singularity --container_dir /singularity
