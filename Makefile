IMAGE="ghcr.io/metcalfc/snapshot-base:jammy"
SNAPSHOT=$(shell grep SNAPSHOT config.toml | cut -d'=' -f2)
BUILD_DATE=$(shell date -u +'%Y-%m-%dT%H:%M:%SZ')
GIT_HASH=$(shell git rev-parse HEAD)

.PHONY: bump build

buildx:
	docker buildx create --name snapshot --use --bootstrap

bump:
	echo "SNAPSHOT=$(date -u +'%Y%m%d')" > config.toml

build:
	docker buildx use snapshot
	docker buildx build --platform linux/amd64,linux/arm64 \
		--build-arg BUILD_DATE=$(BUILD_DATE) --build-arg SNAPSHOT=$(SNAPSHOT) --build-arg GIT_HASH=$(GIT_HASH) \
		-t $(IMAGE) --push .