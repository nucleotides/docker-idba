FROM nucleotides/docker-base
MAINTAINER Michael Barton, mail@michaelbarton.me.uk

RUN apt-get install -y idba
ADD run run
