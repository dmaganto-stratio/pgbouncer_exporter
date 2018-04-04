FROM        alpine AS build
MAINTAINER  Daniel Maganto Martín <dmagantomartin@gmail.com>

RUN apk update
RUN apk add --update go=1.9.4-r0 gcc=6.4.0-r5 g++=6.4.0-r5 git
WORKDIR /
ENV GOPATH /pgbouncer_exporter
RUN git clone -b feature/kms git@github.com:dmaganto-stratio/pgbouncer_exporter.git 
RUN cd /pgbouncer_exporter && (go get || true) && go build
 
FROM alpine
COPY --from=build /pgbouncer_exporter/pgbouncer_exporter /bin/pgbouncer_exporter

EXPOSE 9127 
ENTRYPOINT [ "/bin/pgbouncer_exporter" ]
