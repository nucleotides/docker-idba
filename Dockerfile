FROM debian:jessie
MAINTAINER Michael Barton, mail@michaelbarton.me.uk

RUN apt-get update -y
RUN apt-get install -y gcc build-essential make sed autoconf fastx-toolkit

ADD https://github.com/loneknightpy/idba/releases/download/1.1.2/idba-1.1.2.tar.gz idba.tar.gz
RUN tar xzf /idba.tar.gz
RUN sed --in-place 's/kMaxShortSequence = 128;/kMaxShortSequence = 1024;/' /idba-1.1.2/src/sequence/short_sequence.h

# See https://groups.google.com/forum/#!topic/hku-idba/T2mcHkDOpBU
RUN sed --in-place 's/contig_graph.MergeSimilarPath();//g' /idba-1.1.2/src/sequence/short_sequence.h

RUN cd /idba-1.1.2 && \
       ./configure && \
       make && \
       make install
RUN mv /idba-1.1.2/bin/* /usr/local/bin/

ADD run /usr/local/bin/
ADD Procfile /
ENTRYPOINT ["/usr/local/bin/run"]
