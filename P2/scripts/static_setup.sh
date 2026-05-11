#!/bin/sh

# ─────────────────────────────────────────────
# BADASS P2 - Setup VXLAN statique
# Usage: ./setup_p2.sh
# ─────────────────────────────────────────────

PROJECT_ID="a3649233-27f8-4f25-8ded-53f9d2dd2f0e"

R1="GNS3.router_nponchon-1.${PROJECT_ID}"
R2="GNS3.router_nponchon-2.${PROJECT_ID}"
H1="GNS3.host_nponchon-1.${PROJECT_ID}"
H2="GNS3.host_nponchon-2.${PROJECT_ID}"

exec_r1() { docker exec -i "$R1" sh -c "$1"; }
exec_r2() { docker exec -i "$R2" sh -c "$1"; }
exec_h1() { docker exec -i "$H1" sh -c "$1"; }
exec_h2() { docker exec -i "$H2" sh -c "$1"; }

log() { echo "\n\033[1;34m>>> $1\033[0m"; }

# ─────────────────────────────────────────────
log "ROUTER 1 - Nettoyage"
# ─────────────────────────────────────────────
exec_r1 "ip link set vxlan10 nomaster 2>/dev/null; ip link del vxlan10 2>/dev/null; ip link del br0 2>/dev/null; true"

log "ROUTER 1 - IPs underlay"
exec_r1 "ip addr flush dev eth0"
exec_r1 "ip addr add 10.1.1.1/30 dev eth0"
exec_r1 "ip link set eth0 up"

log "ROUTER 1 - Bridge + VXLAN"
exec_r1 "ip link add br0 type bridge"
exec_r1 "ip link add vxlan10 type vxlan id 10 dstport 4789 remote 10.1.1.2 local 10.1.1.1 dev eth0"
exec_r1 "ip link set vxlan10 master br0"
exec_r1 "ip link set eth1 master br0"
exec_r1 "ip addr flush dev eth1"
exec_r1 "ip addr add 30.1.1.1/24 dev br0"
exec_r1 "ip link set vxlan10 up"
exec_r1 "ip link set br0 up"
exec_r1 "ip link set eth1 up"

# ─────────────────────────────────────────────
log "ROUTER 2 - Nettoyage"
# ─────────────────────────────────────────────
exec_r2 "ip link set vxlan10 nomaster 2>/dev/null; ip link del vxlan10 2>/dev/null; ip link del br0 2>/dev/null; true"

log "ROUTER 2 - IPs underlay"
exec_r2 "ip addr flush dev eth0"
exec_r2 "ip addr add 10.1.1.2/30 dev eth0"
exec_r2 "ip link set eth0 up"

log "ROUTER 2 - Bridge + VXLAN"
exec_r2 "ip link add br0 type bridge"
exec_r2 "ip link add vxlan10 type vxlan id 10 dstport 4789 remote 10.1.1.1 local 10.1.1.2 dev eth0"
exec_r2 "ip link set vxlan10 master br0"
exec_r2 "ip link set eth1 master br0"
exec_r2 "ip addr flush dev eth1"
exec_r2 "ip addr add 30.1.1.2/24 dev br0"
exec_r2 "ip link set vxlan10 up"
exec_r2 "ip link set br0 up"
exec_r2 "ip link set eth1 up"

# ─────────────────────────────────────────────
log "HOST 1 - IP"
# ─────────────────────────────────────────────
exec_h1 "ip addr flush dev eth0"
exec_h1 "ip addr add 30.1.1.1/24 dev eth0"
exec_h1 "ip link set eth0 up"

log "HOST 2 - IP"
exec_h2 "ip addr flush dev eth0"
exec_h2 "ip addr add 30.1.1.2/24 dev eth0"
exec_h2 "ip link set eth0 up"

# ─────────────────────────────────────────────
log "VERIFICATION"
# ─────────────────────────────────────────────
echo "\n--- Router 1 : vxlan10 ---"
exec_r1 "ip link show vxlan10"

echo "\n--- Router 2 : vxlan10 ---"
exec_r2 "ip link show vxlan10"

echo "\n--- Bridge tables ---"
exec_r1 "bridge fdb show dev vxlan10"
exec_r2 "bridge fdb show dev vxlan10"

echo "\n--- Ping host1 -> host2 ---"
exec_h1 "ping -c 3 30.1.1.2"