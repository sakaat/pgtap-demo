FROM postgres:12-alpine

RUN apk add --no-cache --update \
    curl wget postgresql-client postgresql-dev git openssl build-base make perl perl-dev \
    && rm -rf /var/cache/apk/* /tmp/*

RUN cpan TAP::Parser::SourceHandler::pgTAP

ENV PGTAP_VERSION=v1.1.0
RUN git clone git://github.com/theory/pgtap.git \
    && cd pgtap \
    && git checkout tags/$PGTAP_VERSION \
    && make

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["postgres"]
