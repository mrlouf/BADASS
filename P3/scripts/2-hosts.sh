#!/bin/bash

# ─────────────────────────────────────────────
# BADASS P3 - Setup Hosts: configure IPs and default gateway
# Usage: ./2-hosts.sh
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


# ─────────────────────────────────────────────
log "Stage 0 - IPs for everyone\n"
# ─────────────────────────────────────────────

# ─────────────────────────────────────────────
vtysh_cmd "$H1" "configure terminal
interface eth0
  ip address 10.1.1.2/30
exit
end
write memory" $SILENCE