FROM mooxe/base:latest

MAINTAINER FooTearth "footearth@gmail.com"
ENV NEWLISP_FILENAME newlisp_10.6.2-utf8_amd64.deb

WORKDIR /root

# system update
RUN \
  apt-get update && \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get autoremove -y

RUN \
# TODO install asdf
  apt-get install -y \
    cl-launch \
    sbcl sbcl-doc \
    clisp clisp-doc

#   ccl
#   axel http://ccl.clozure.com/ftp/pub/release/1.10/ccl-1.10-linuxx86.tar.gz

#   gcl gcl-doc

RUN \
  axel http://www.newlisp.org/downloads/$NEWLISP_FILENAME && \
  dpkg -i $NEWLISP_FILENAME && \
  rm -rf $NEWLISP_FILENAME
