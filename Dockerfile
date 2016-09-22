# vim:set ft=dockerfile:
FROM alpine:latest
MAINTAINER DI GREGORIO Nicolas "nicolas.digregorio@gmail.com"

### Environment variables
ENV LANG='en_US.UTF-8' \
    LANGUAGE='en_US.UTF-8' \
    TERM='xterm' 

### Install Application
RUN apk --no-cache upgrade && \
    apk add --no-cache --virtual=build-deps \
      make \
      gcc \
      g++ \
      python-dev \
      py-pip \
      openssl-dev \
      curl-dev \
      musl-dev \
      git \
      py-pip  && \
    apk add --no-cache --virtual=run-deps \
      python \ 
      ssmtp \
      libcurl \
      su-exec && \
    pip --no-cache-dir install --upgrade setuptools && \
    pip --no-cache-dir install --upgrade \
      pyv8 \
      pyopenssl \
      tesseract \
      pycrypto \
      Pillow \
      feedparser \
      BeautifulSoup \
      thrift \
      beaker \
      jinja2 \
      pycurl && \
    git clone --depth 1 https://github.com/pyload/pyload.git /opt/pyload && \
    apk del --no-cache --purge \
      build-deps  && \
    rm -rf /tmp/* \
           /var/cache/apk/*  \
           /var/tmp/*


### Volume
VOLUME ["/downloads","/config"]

### Expose ports
EXPOSE 8000 7227

### Running User: not used, managed by docker-entrypoint.sh
#USER pyload

### Start pyload
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["pyload"]

