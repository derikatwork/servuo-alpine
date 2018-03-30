FROM alpine:3.7

ENV UO_HOME /UO
VOLUME /client /UO

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN apk add --no-cache bash \
                       libgdiplus-dev \
                       mono \
                       make \
                       git \
                       gosu; \
    ln -s /usr/bin/gosu /usr/local/bin/gosu; \
    addgroup uo; \
    adduser -D -S uo -s /bin/bash -h ${UO_HOME} -g "UO server user" -G uo;

COPY docker-entrypoint.sh /
COPY AccountPrompt.cs /

RUN chmod +x /docker-entrypoint.sh

EXPOSE 2593

CMD [ "/docker-entrypoint.sh" ]
