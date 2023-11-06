    ARG SNAPSHOT
    ARG BUILD_DATE
    ARG GIT_HASH

    FROM ubuntu:jammy
    RUN apt-get update && apt-get install -y ca-certificates \
        && rm -rf /var/lib/apt/lists/* \
        && sed -i "s#http://ports.ubuntu.com/ubuntu-ports/#https://snapshot.ubuntu.com/ubuntu/${SNAPSHOT}T000000Z#g" /etc/apt/sources.list
    LABEL "org.opencontainers.image.source"="https://github.com/metcalfc/snapshot-base.git"
    LABEL "org.opencontainers.image.created"="${BUILD_DATE}"
    LABEL "org.opencontainers.image.revision"="${GIT_HASH}"
