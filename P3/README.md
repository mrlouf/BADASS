# P3 - Part 3

This directory contains the files and resources for Part 3 of the BADASS project.

## BGP EVPN

In this third and last part, we need to set up a BGP EVPN. The name sounds complicated, but in reality the concept is not that hard to understand, at least for the basic principle.

In the previous level, we used a VXLAN in multicast mode, which meant that all the routers were listening to a same multicast IP for communication. While this centralises information, it also means that some routers are receiving broadcasts that are not for them, generating noise and flood, especially on a larger lab like a datacenter.

The BGP EVPN network aims to fix that by introducing a Route Reflector (RR) and OSPF. A RR is a router whose role is to coordinate the MAC addresses provided by each router; each VTEP indicates to the RR the MAC addresses within its own subnetwork, and the RR then dispatches them to the other VTEP, preventing unnecessary flood and noise.

While packets necessarily still pass physically through the RR, it does _not_ process them, it only dispatches the information about the MAC addresses to the other VTEP. The actual handling of the packets (from encapsulation to decapsulation) is still done by the VTEP, and the RR is only used for the exchange of information about the MAC addresses.

## OSPF

The OSPF is a routing protocol based on Dijkstra's algorithm to calculate the shortest path between two endpoints.

In this project, we use this protocol to exchange information about the routes between the routers, and to determine the best path for a packet to reach its destination. This might not be particularly representative in a small lab like this one where the path options are very limited, but in a larger network like a datacenter, it is crucial to have a routing protocol that can dynamically adapt to changes in the network topology and traffic conditions.



### References

[OSPF Routing with FRRouting on Ubuntu](https://oneuptime.com/blog/post/2026-03-02-how-to-set-up-ospf-routing-with-frrouting-on-ubuntu/view)
