FROM mooxe/base:latest

MAINTAINER FooTearth "footearth@gmail.com"

WORKDIR /root

# system update
RUN \
  apt-get update && \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get autoremove -y

RUN apt-get install -y make
# clisp clisp-doc
# gcl gcl-doc

ENV DOWNLOAD_PATH /root/downloads
RUN mkdir -p $DOWNLOAD_PATH

##########################################
# sbcl && asdf
##########################################
ENV SBCL_VERSION 1.2.16
ENV SBCL_PATH sbcl-$SBCL_VERSION-x86-64-linux
ENV SBCL_FILE $SBCL_PATH-binary.tar.bz2

RUN \

  curl \

    # sbcl
    -o $DOWNLOAD_PATH/$SBCL_FILE \
    "http://nchc.dl.sourceforge.net/project/sbcl/sbcl/$SBCL_VERSION/$SBCL_FILE" \
    # http://nchc.dl.sourceforge.net/project/sbcl/sbcl/1.2.16/sbcl-1.2.16-x86-64-linux-binary.tar.bz2
    # https://codeload.github.com/sbcl/sbcl/tar.gz/sbcl-1.2.16

    # asdf - include in sbcl
    # https://gitlab.common-lisp.net/asdf/asdf/repository/archive.tar.gz?ref=3.1.5.18

  && \

  tar xvf \
    $DOWNLOAD_PATH/$SBCL_FILE \
    -C $DOWNLOAD_PATH

WORKDIR $DOWNLOAD_PATH/$SBCL_PATH
RUN sh $DOWNLOAD_PATH/$SBCL_PATH/install.sh
WORKDIR /root
###########################################


###########################################
# cl-launch
###########################################
ENV CLL_VERSION 4.1.3
ENV CLL_PATH cl-launch-$CLL_VERSION
ENV CLL_FILE $CLL_PATH.tar.gz

RUN \

  curl \
    -o $DOWNLOAD_PATH/$CLL_FILE \
    "https://gitlab.common-lisp.net/xcvb/cl-launch/repository/archive.tar.gz?ref=$CLL_VERSION" \
  && \

  tar xvf \
    $DOWNLOAD_PATH/$CLL_FILE \
    -C $DOWNLOAD_PATH \
  && \

  sh -c "mv $DOWNLOAD_PATH/$CLL_PATH-* $DOWNLOAD_PATH/$CLL_PATH"

WORKDIR $DOWNLOAD_PATH/$CLL_PATH
RUN make install
WORKDIR /root
###########################################

ENV NEWLISP_FILENAME newlisp_10.6.2-utf8_amd64.deb
# newLISP
RUN \
  axel http://www.newlisp.org/downloads/$NEWLISP_FILENAME && \
  dpkg -i $NEWLISP_FILENAME && \
  rm -rf $NEWLISP_FILENAME


RUN rm -rf $DOWNLOAD_PATH
WORKDIR /root

#   CLL
#   axel http://CLL.clozure.com/ftp/pub/release/1.10/CLL-1.10-linuxx86.tar.gz
