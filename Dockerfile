FROM alpine:3.7
MAINTAINER Karmashkin <vlad@zolotous.com>

ENV UO_HOME /UO
VOLUME /client

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN apk add --no-cache bash \
                       libgdiplus-dev \
                       mono \
                       make \
                       git \
                       gosu; \
    ln -s /usr/bin/gosu /usr/local/bin/gosu; \
    addgroup uo; \
    adduser -D -S uo -s /bin/bash -h ${UO_HOME} -g "UO server user" -G uo; \
    chown -R uo:uo ${UO_HOME}; \
    git clone https://github.com/ServUO/ServUO ${UO_HOME}/ServUO; \

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

EXPOSE 2593

CMD [ "/docker-entrypoint.sh" ]
