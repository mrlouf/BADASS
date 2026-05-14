#!/bin/bash

# ─────────────────────────────────────────────
# BADASS P3 - Setup VXLAN: configure VXLAN tunnels
# Usage: ./3-setup_vxlan.sh
# ─────────────────────────────────────────────

PROJECT_ID="afc55a2d-ce92-40fc-87a4-461572f43474"

SILENCE="&>/dev/null"

RR="GNS3.nponchon-1.${PROJECT_ID}"

L2="GNS3.nponchon-2.${PROJECT_ID}"
L3="GNS3.nponchon-3.${PROJECT_ID}"
L4="GNS3.nponchon-4.${PROJECT_ID}"

H1="GNS3.host_nponchon-1.${PROJECT_ID}"
H2="GNS3.host_nponchon-2.${PROJECT_ID}"
H3="GNS3.host_nponchon-3.${PROJECT_ID}"

log() { echo -e "\033[1;34m>>> $1\033[0m"; }

setup_vxlan() {
    CONTAINER=$1
    HOST_IP=$2
    docker exec -i "$CONTAINER" ip link add br0 type bridge
    docker exec -i "$CONTAINER" ip link add vxlan10 type vxlan id 10 dstport 4789 local $HOST_IP dev eth0
    docker exec -i "$CONTAINER" ip link set vxlan10 master br0
    docker exec -i "$CONTAINER" ip link set eth1 master br0
    docker exec -i "$CONTAINER" ip link set vxlan10 up
    docker exec -i "$CONTAINER" ip link set br0 up
    docker exec -i "$CONTAINER" ip link set eth1 up
}


# ─────────────────────────────────────────────
log "Stage 0 - IPs for everyone\n"
# ─────────────────────────────────────────────

setup_vxlan "$L2" "1.1.1.2"
setup_vxlan "$L3" "1.1.1.3"
setup_vxlan "$L4" "1.1.1.4"

