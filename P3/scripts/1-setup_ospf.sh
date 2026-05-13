#!/bin/bash

# ─────────────────────────────────────────────
# BADASS P3 - Setup Routers: configure IPs and OSPF
# Usage: ./1-routers.sh
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

vtysh_cmd() {
    CONTAINER=$1
    CMD=$2
    docker exec -i "$CONTAINER" vtysh -c "$CMD" &>/dev/null 
}
 
ospf_config() {
    CONTAINER=$1
    ROUTER_ID=$2
    LO_IP=$3
    IFACES=$4

    CONFIG="configure terminal
router ospf
  ospf router-id ${ROUTER_ID}
  no network 0.0.0.0/0 area 0
exit
interface lo
  ip address ${LO_IP}/32
  ip ospf area 0
exit"

    for IFACE in $IFACES; do
        CONFIG="${CONFIG}
interface ${IFACE}
  ip ospf area 0
exit"
    done
 
    CONFIG="${CONFIG}
end
write memory"
 
    docker exec -i "$CONTAINER" vtysh &>/dev/null <<EOF
$CONFIG
EOF
}


# ─────────────────────────────────────────────
log "Stage 0 - IPs for everyone\n"
# ─────────────────────────────────────────────

# First we need to set IP addresses on all interfaces

# ─────────────────────────────────────────────
vtysh_cmd "$RR" "configure terminal
interface eth0
  ip address 10.1.1.1/30
exit
interface eth1
  ip address 10.1.1.5/30
exit
interface eth2
  ip address 10.1.1.9/30
exit
end
write memory" $SILENCE

# ─────────────────────────────────────────────
vtysh_cmd "$L2" "configure terminal
interface eth0
  ip address 10.1.1.2/30
exit
end
write memory" $SILENCE

# ─────────────────────────────────────────────
vtysh_cmd "$L3" "configure terminal
interface eth1
  ip address 10.1.1.6/30
exit
end
write memory" $SILENCE

# ─────────────────────────────────────────────
vtysh_cmd "$L4" "configure terminal
interface eth2
  ip address 10.1.1.10/30
exit
end
write memory" $SILENCE

# ─────────────────────────────────────────────
log "Stage 1 - OSPF for everyone\n"
# ─────────────────────────────────────────────

# Now, we can configure OSPF on all routers:
# Start with RR: its loopback will be the router-id, and all interfaces will be in area 0
# Then set the loopback and the single interface of each leaf in area 0 as well

# ─────────────────────────────────────────────
log "RR (nponchon-1) - router-id 1.1.1.1"
ospf_config "$RR" "1.1.1.1" "1.1.1.1" "eth0 eth1 eth2" $SILENCE
 
# ─────────────────────────────────────────────
log "Leaf nponchon-2 - router-id 1.1.1.2"
ospf_config "$L2" "1.1.1.2" "1.1.1.2" "eth0" $SILENCE
 
# ─────────────────────────────────────────────
log "Leaf nponchon-3 - router-id 1.1.1.3"
ospf_config "$L3" "1.1.1.3" "1.1.1.3" "eth1" $SILENCE
 
# ─────────────────────────────────────────────
log "Leaf nponchon-4 - router-id 1.1.1.4\n"
ospf_config "$L4" "1.1.1.4" "1.1.1.4" "eth2" $SILENCE
 
# ─────────────────────────────────────────────
log "VERIFICATION"
 
echo -e "\n--- OSPF neighbours on RR (should show Leaves) ---"
docker exec -i "$RR" vtysh -c "show ip ospf neighbor"
 
echo -e "\n--- OSPF routes on RR ---"
docker exec -i "$RR" vtysh -c "show ip route ospf"
 
echo -e "\n--- OSPF neighbours on nponchon-2 ---"
docker exec -i "$L2" vtysh -c "show ip ospf neighbor"
 
sleep 0.5
echo -e "\n--- Ping loopback RR from nponchon-2 ---"
docker exec -i "$L2" ping -c 3 1.1.1.1
