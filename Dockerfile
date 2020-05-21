FROM ubuntu

# This is required to prevent tzdata prompting for
# user input when it is installed as a dependency
# for singularity. This results in the timezone
# being set to UTC. Use "dpkg-reconfigure tzdata"
# to reset the timezone, if you care.
#
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt upgrade -y && \
    apt install -y curl default-jre git nodejs python3-pip vim zip

ADD clone-janis.sh /
ADD build-janis.sh /
ADD install-singularity.sh /
RUN /install-singularity.sh
