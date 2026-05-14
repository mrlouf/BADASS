#!/bin/bash

# ─────────────────────────────────────────────
# BADASS P3 - Setup Hosts: configure IPs
# Usage: ./4-setup_hosts.sh
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

setup_host_ip() {
    CONTAINER=$1
    HOST_IP=$2
    docker exec -i "$CONTAINER" ip addr add $HOST_IP/24 dev eth0
    docker exec -i "$CONTAINER" ip link set eth0 up &>/dev/null
}


# ─────────────────────────────────────────────
log "Stage 0 - IPs for everyone\n"
# ─────────────────────────────────────────────

setup_host_ip "$H1" "20.1.1.1"
setup_host_ip "$H2" "20.1.1.2"
setup_host_ip "$H3" "20.1.1.3"
