FROM mooxe/base:latest

MAINTAINER FooTearth "footearth@gmail.com"

WORKDIR /root

# system update
RUN \
  apt-get update && \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get autoremove -y

RUN \
  apt-get install -y \
    cl-launch \
    sbcl sbcl-doc \
    clisp clisp-doc \
    gcl gcl-doc
