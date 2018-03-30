FROM alpine:3.7

ENV UO_HOME /UO
VOLUME /client /UO

ARG USERNAME=admin
ARG PASSWORD=admin

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

RUN sed -i "s/username/$USERNAME/g" /AccountPrompt.cs
RUN sed -i "s/password/$PASSWORD/g" /AccountPrompt.cs

RUN chmod +x /docker-entrypoint.sh

EXPOSE 2593

CMD [ "/docker-entrypoint.sh" ]
