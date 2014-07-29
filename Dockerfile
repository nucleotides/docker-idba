FROM debian:jessie
MAINTAINER Michael Barton, mail@michaelbarton.me.uk

RUN apt-get update -y
RUN apt-get install -y gcc build-essential make sed autoconf fastx-toolkit

ADD http://hku-idba.googlecode.com/files/idba-1.1.1.tar.gz /tmp/
RUN tar xzf /tmp/idba-1.1.1.tar.gz
RUN sed --in-place 's/kMaxShortSequence = 128;/kMaxShortSequence = 1024;/' /idba-1.1.1/src/sequence/short_sequence.h

RUN cd /idba-1.1.1 && ./configure && make && make install
RUN mv /idba-1.1.1/bin/* /usr/local/bin/

ADD run /usr/local/bin/
ADD Procfile /
ENTRYPOINT ["/usr/local/bin/run"]
