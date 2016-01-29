FROM jeffutter/mogile-tracker:latest
MAINTAINER hrchu "hrchu@cht.com.tw"

RUN dpkg --add-architecture i386 \
  && apt-get update \
  && apt-get install -y default-jdk maven sharutils vim telnet git \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD run.sh /run.sh

ENTRYPOINT ["/run.sh"]

 
 
