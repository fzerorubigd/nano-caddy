FROM alpine:edge
MAINTAINER fzerorubigd <fzero@rubi.gd>

ENV GOPATH /go
ENV GOBIN /bin
ENV CADDY_TAG v0.8.0

RUN apk add --update musl \
    && apk add -t build-tools go mercurial git \
    && mkdir /go \
    && cd /go \
    && go get -tags=$CADDY_TAG github.com/mholt/caddy \
    && mv $GOPATH/bin/caddy /bin \
    && mkdir /caddy \
    && apk del --purge build-tools go mercurial git \
    && rm -rf /go /var/cache/apk/*

ADD dicker-init.sh  /bin/docker-init.sh
CMD chmod a+x /bin/docker-init.sh

EXPOSE     2015 80 443
CMD mkdir -p /{caddy,root/.caddy,logs}
VOLUME     /caddy /root/.caddy /logs
WORKDIR    /caddy
ENTRYPOINT ["/bin/docker-init.sh"]
CMD        ["caddy" ]
