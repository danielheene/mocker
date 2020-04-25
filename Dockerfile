FROM alpine:latest AS binaries
RUN apk add --no-cache \
    docker-cli \
    ncurses

##################################################

FROM bash:5

ARG IMAGE
ARG VERSION

ENV IMAGE ${IMAGE}
ENV VERSION ${VERSION}

LABEL com.dnsdrone.mocker=true
LABEL com.dnsdrone.mocker.version=$VERSION
LABEL com.dnsdrone.mocker.image=$IMAGE

COPY --from=binaries  /usr/bin/docker  /usr/bin/
COPY --from=binaries  /usr/bin/tput    /usr/bin/

ADD mocked-labels /mocked-labels/

ADD mocker /
RUN chmod +x /mocker

WORKDIR /
ENTRYPOINT ["/mocker"]
CMD [""]
