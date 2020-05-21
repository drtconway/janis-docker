FROM ubuntu
ADD clone-janis.sh /
ADD build-janis.sh /
RUN apt update && \
    apt upgrade -y && \
    apt install -y git python3-pip singularity vim zip
