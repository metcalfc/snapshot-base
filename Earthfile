
VERSION 0.7
ARG --global SNAPSHOT = "20231104"

all:
    BUILD \
        --platform=linux/amd64 \
        --platform=linux/arm64 \
        +docker

docker:
    FROM ubuntu:jammy
    ARG BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ')
    RUN apt-get update && apt-get install -y ca-certificates \
        && rm -rf /var/lib/apt/lists/* \
        && sed -i "s#http://ports.ubuntu.com/ubuntu-ports/#https://snapshot.ubuntu.com/ubuntu/${SNAPSHOT}T000000Z#g" /etc/apt/sources.list
    LABEL "org.opencontainers.image.source"="${EARTHLY_GIT_ORIGIN_URL}"
    LABEL "org.opencontainers.image.created"="${BUILD_DATE}"
    LABEL "org.opencontainers.image.revision"="${EARTHLY_GIT_HASH}"
    LABEL "org.opencontainers.image.title"="snapshot-base"
    SAVE IMAGE --push ghcr.io/metcalfc/snapshot-base:jammy
