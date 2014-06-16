FROM debian:jessie
MAINTAINER Michael Barton, mail@michaelbarton.me.uk

RUN apt-get update -y
RUN apt-get install -y wget
RUN wget --quiet http://hku-idba.googlecode.com/files/idba-1.1.1.tar.gz -O /tmp/idba-1.1.1.tar.gz

RUN apt-get install -y gcc build-essential make sed autoconf

ADD install /usr/local/bin/
RUN /usr/local/bin/install

ADD run /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/run"]
