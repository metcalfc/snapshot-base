
VERSION 0.7

LOCALLY
ARG --global BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ')
ARG --global SNAPSHOT=$(grep SNAPSHOT config.toml | cut -d'=' -f2)

bump:
    LOCALLY
    RUN echo "SNAPSHOT=$(date -u +'%Y%m%d')" > config.toml

build:
    BUILD \
        --platform=linux/amd64 \
        --platform=linux/arm64 \
        +docker

docker:
    FROM ubuntu:jammy
    RUN apt-get update && apt-get install -y ca-certificates \
        && rm -rf /var/lib/apt/lists/* \
        && sed -i "s#http://ports.ubuntu.com/ubuntu-ports/#https://snapshot.ubuntu.com/ubuntu/${SNAPSHOT}T000000Z#g" /etc/apt/sources.list
    LABEL "org.opencontainers.image.source"="${EARTHLY_GIT_ORIGIN_URL}"
    LABEL "org.opencontainers.image.created"="${BUILD_DATE}"
    LABEL "org.opencontainers.image.revision"="${EARTHLY_GIT_HASH}"
    SAVE IMAGE ghcr.io/metcalfc/snapshot-base:jammy

test:
    FROM +docker
    RUN apt-get update && apt-get install -y curl
