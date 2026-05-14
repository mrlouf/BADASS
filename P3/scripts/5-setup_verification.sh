#!/bin/bash

# ─────────────────────────────────────────────
# BADASS P3 - Setup Verification: check BGP and VXLAN configs
# Usage: ./5-setup_verification.sh
# ─────────────────────────────────────────────

PROJECT_ID="afc55a2d-ce92-40fc-87a4-461572f43474"

SILENCE="&>/dev/null"

RR="GNS3.nponchon-1.${PROJECT_ID}"

L1="GNS3.nponchon-2.${PROJECT_ID}"
L2="GNS3.nponchon-3.${PROJECT_ID}"
L3="GNS3.nponchon-4.${PROJECT_ID}"

H1="GNS3.host_nponchon-1.${PROJECT_ID}"
H2="GNS3.host_nponchon-2.${PROJECT_ID}"
H3="GNS3.host_nponchon-3.${PROJECT_ID}"

log() { echo -e "\033[1;34m>>> $1\033[0m"; }

vtysh_cmd() {
    CONTAINER=$1
    CMD=$2
    docker exec -i "$CONTAINER" vtysh -c "$CMD" &>/dev/null 
}

# ─────────────────────────────────────────────
log "VERIFICATION"
# ─────────────────────────────────────────────

echo -e "\n--- RR (nponchon-1) - BGP Config ---"
docker exec -i "$RR" vtysh -c "show ip ospf neighbor"
docker exec -i "$RR" vtysh -c "show bgp l2vpn evpn"

# ─────────────────────────────────────────────
echo -e "\n--- L1 (nponchon-2) - BGP Config ---"
docker exec -i "$L1" vtysh -c "show ip ospf neighbor"
docker exec -i "$L1" vtysh -c "show bgp l2vpn evpn"

# ─────────────────────────────────────────────
echo -e "\n--- L2 (nponchon-3) - BGP Config ---"
docker exec -i "$L2" vtysh -c "show ip ospf neighbor"
docker exec -i "$L2" vtysh -c "show bgp l2vpn evpn"

# ─────────────────────────────────────────────
echo -e "\n--- L3 (nponchon-4) - BGP Config ---"
docker exec -i "$L3" vtysh -c "show ip ospf neighbor"
docker exec -i "$L3" vtysh -c "show bgp l2vpn evpn"


