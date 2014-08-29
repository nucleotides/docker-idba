FROM debian:jessie
MAINTAINER Michael Barton, mail@michaelbarton.me.uk

RUN apt-get update -y
RUN apt-get install -y gcc build-essential make sed autoconf fastx-toolkit

# See https://groups.google.com/d/msg/hku-idba/RzTkrVTod8o/kNj_ZghK4eQJ
# This is why 1.0.9 is used instead of the latest 1.1.2
ADD https://hku-idba.googlecode.com/files/idba_ud-1.0.9.tar.gz /tmp/idba.tar.gz
RUN mkdir /tmp/idba
RUN tar xzf /tmp/idba.tar.gz --directory /tmp/idba --strip-components=1

RUN sed --in-place 's/kMaxShortSequence = 128;/kMaxShortSequence = 1024;/' /tmp/idba/src/sequence/short_sequence.h

# See https://groups.google.com/forum/#!topic/hku-idba/T2mcHkDOpBU
RUN sed --in-place 's/contig_graph.MergeSimilarPath();//g' /tmp/idba/src/release/idba_ud.cpp

RUN cd /tmp/idba && \
       ./configure && \
       make && \
       make install
RUN mv /tmp/idba/bin/* /usr/local/bin/

ADD run /usr/local/bin/
ADD Procfile /
ENTRYPOINT ["/usr/local/bin/run"]
