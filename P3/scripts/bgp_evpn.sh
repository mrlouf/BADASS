#!/bin/bash

# ─────────────────────────────────────────────
# BADASS P3 - Setup BGP EVPN
# Usage: ./bgp_evpn.sh
# ─────────────────────────────────────────────

PROJECT_ID="afc55a2d-ce92-40fc-87a4-461572f43474"

RR="GNS3.nponchon-1.${PROJECT_ID}"

R2="GNS3.nponchon-2.${PROJECT_ID}"
R3="GNS3.nponchon-3.${PROJECT_ID}"
R4="GNS3.nponchon-4.${PROJECT_ID}"

H1="GNS3.host_nponchon-1.${PROJECT_ID}"
H2="GNS3.host_nponchon-2.${PROJECT_ID}"
H3="GNS3.host_nponchon-3.${PROJECT_ID}"

exec_rr() { docker exec -i "$RR" sh -c "$1"; }

exec_r2() { docker exec -i "$R2" sh -c "$1"; }
exec_r3() { docker exec -i "$R3" sh -c "$1"; }
exec_r4() { docker exec -i "$R4" sh -c "$1"; }

exec_h1() { docker exec -i "$H1" sh -c "$1"; }
exec_h2() { docker exec -i "$H2" sh -c "$1"; }
exec_h3() { docker exec -i "$H3" sh -c "$1"; }

log() { echo "\n\033[1;34m>>> $1\033[0m"; }

