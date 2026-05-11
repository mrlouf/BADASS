#!/bin/sh

cd "$(dirname "$0")"

# Pull FRR image from Quay
docker pull quay.io/frrouting/frr:10.5.3

docker tag quay.io/frrouting/frr:10.5.3 badass-frrouting

# Build and tag the images for GNS3 to use them
docker build host_nponchon/ -t "host_nponchon:latest"
docker build router_nponchon/ -t "router_nponchon:latest"