# P3 - Part 3

This directory contains the files and resources for Part 3 of the BADASS project.

## BGP EVPN

In this third and last part, we need to set up a BGP EVPN. The name sounds complicated, but in reality the concept is not that hard to understand, at least for the basic principle.

In the previous level, we used a VXLAN in multicast mode, which meant that all the routers were listening to a same multicast IP for communication. While this centralises information, it also means that some routers are receiving broadcasts that are not for them, generating noise and flood, especially on a larger lab like a datacenter.

The BGP EVPN network aims to fix that by introducing a Route Reflector (RR) and OSFP. A RR is a router whose role is to coordinate the MAC addresses provided by each router; each VTEP indicates to the RR the MAC addresses within its own subnetwork, and the RR then dispatches them to the other VTEP, preventing unnecessary flood and noise.

The OFSP is a routing protocol based on Dijkstra's algorithm to calculate the shortest path between two endpoints.

### References

[OSPF Routing with FRRouting on Ubuntu](https://oneuptime.com/blog/post/2026-03-02-how-to-set-up-ospf-routing-with-frrouting-on-ubuntu/view)
