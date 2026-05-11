# P2 - Part 2

This directory contains the files and resources for Part 2 of the BADASS project.

## VXLAN

A Virtual eXtensible Local Area Network is a type of network that simulates a LAN between two hosts that might not be on the same network. In this P2, we are asked to create a simple VXLAN between host_1 and host_2. Each host is only connected via eth0 to a router that acts as a VTEP.

When host_1 pings host_2, the packet reaches the router_1 that then encapsulates it in an UDP datagram. The datagram travels in the subnetwork to the exit point of the tunnel, router_2 that then decapsulates the datagram. It reaches host_2, and the Ethernet frame is completely oblivious to the whole process, so that for both hosts, it seems like the remote host is literally next door:

```sh
/ # hostname
host_ponchon-1
/ # traceroute 30.1.1.20
traceroute to 30.1.1.20 (30.1.1.20), 30 hops max, 46 byte packets
 1  30.1.1.20 (30.1.1.20)  0.271 ms  0.275 ms  0.126 ms
```

## Static vs. Dynamic cast

This first part of P2 must be done using static cast, which means that the router's IPs in the VXLAN are hardcoded:

```sh
ip link add vxlan10 type vxlan id 10 dstport 4789 remote 10.1.1.2 local 10.1.1.1 dev eth0
```

To make the switch to dynamic cast, we need to add a multicast IP via `group`:

```sh
ip link add vxlan10 type vxlan id 10 dstport 4789 group 239.1.1.1 local 10.1.1.1 dev eth0
```

The rest of the VXLAN setup - name, VNI, port, etc - stays the same.

The multicast IP acts as a channel to regroup all the routers in the VXLAN: when router_1 sends a packet there, router_2 gets notified and so discovers the MAC address of router_1, without need of hardcoding the IP (more scalable) or broadcasting the whole network (less overhead).
