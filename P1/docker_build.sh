#!/bin/sh

# Build and tag the images for GNS3 to use them

docker build ./host_nponchon/ -t "host_ponchon:latest"
docker build ./router_nponchon/ -t "router_ponchon:latest"

