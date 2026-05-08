#!/bin/sh

# Pull FRR image from Quay
docker pull quay.io/frrouting/frr:10.5.3

docker tag quay.io/frrouting/frr:10.5.3 badass-frrouting

# Build and tag the images for GNS3 to use them
docker build host_nponchon/ -t "host_ponchon:latest"
docker build router_nponchon/ -t "router_ponchon:latest"