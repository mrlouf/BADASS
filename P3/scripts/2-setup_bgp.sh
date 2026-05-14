#!/bin/bash

# ─────────────────────────────────────────────
# BADASS P3 - Setup BGP: configure RR and Leaves
# Usage: ./2-hosts.sh
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
log "Stage 0 - Configure BGP at RR\n"
# ─────────────────────────────────────────────

# ─────────────────────────────────────────────
vtysh_cmd "$RR" "configure terminal
router bgp 65000
  bgp router-id 1.1.1.1
 
  neighbor 1.1.1.2 remote-as 65000
  neighbor 1.1.1.2 update-source lo
  neighbor 1.1.1.3 remote-as 65000
  neighbor 1.1.1.3 update-source lo
  neighbor 1.1.1.4 remote-as 65000
  neighbor 1.1.1.4 update-source lo

  address-family l2vpn evpn
    neighbor 1.1.1.2 activate
    neighbor 1.1.1.3 activate
    neighbor 1.1.1.4 activate
    neighbor 1.1.1.2 route-reflector-client
    neighbor 1.1.1.3 route-reflector-client
    neighbor 1.1.1.4 route-reflector-client
  exit-address-family

exit
end
write memory" 

# ─────────────────────────────────────────────
log "Stage 1 - Configure BGP on Leaves\n"
# ─────────────────────────────────────────────

# ─────────────────────────────────────────────
vtysh_cmd "$L1" "configure terminal
router bgp 65000
  bgp router-id 1.1.1.2
  
  neighbor 1.1.1.1 remote-as 65000
  neighbor 1.1.1.1 update-source lo

  address-family l2vpn evpn
    neighbor 1.1.1.1 activate
    advertise-all-vni
  exit-address-family

exit
end
write memory"

# ─────────────────────────────────────────────
vtysh_cmd "$L2" "configure terminal
router bgp 65000
  bgp router-id 1.1.1.3
  
  neighbor 1.1.1.1 remote-as 65000
  neighbor 1.1.1.1 update-source lo

  address-family l2vpn evpn
    neighbor 1.1.1.1 activate
    advertise-all-vni
  exit-address-family

exit
end
write memory"

# ─────────────────────────────────────────────
vtysh_cmd "$L3" "configure terminal
router bgp 65000
  bgp router-id 1.1.1.4
  
  neighbor 1.1.1.1 remote-as 65000
  neighbor 1.1.1.1 update-source lo

  address-family l2vpn evpn
    neighbor 1.1.1.1 activate
    advertise-all-vni
  exit-address-family

exit
end
write memory"


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


