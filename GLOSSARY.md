# Glossary

BADASS is an extremely complex project that touches a far more incredibly abyssal field of knowledge and technology than I have ever encountered at 42.

This project involves an overwhelming amount of concepts, technologies, tools, and jargon that are new to me, and that are necessary to understand in order to successfully complete the project but more importantly to understand the basics of how the Internet and computer networks work.

This glossary shall be a humble attempt at centralising and defining concepts, acronyms and technologies that I have encountered during the project.

## Definitions

All definitions are my own and may be inaccurate, incomplete or just plain wrong.

- ACL (Access Control Lists): Firewall rules between VLANs. Useful to open or close communication between subnetworks, like staff vs. students at 42, etc.
- AS (Autonomous System):
- BGP (Border Gateway Protocol): Exchanging routes between autonomous systems (like Internet-scale routing)
- BGP EVPN (RFC 7432)
- Bridge:
- DHCP:
- DNS:
- Ethernet:
- IS-IS
- Leaf: see VTEP.
- MAC address:
- MPLS
- Multicast
- OSPF
- Route reflection (=RR):
- Route types:
- Static vs. dynamic cast
- VNI
- VTEP (VXLAN tunnel endpoints): Entry and exit points for VXLAN. These are the endpoints where packets are UDP encapsulated and then enter/exit to reach their destination.
- VLAN (Virtual Local Area Network): A physical network segmented into several logical subnetworks at the L2 level via managed switches. This is a typical infrastructure for an office or a school where all the hosts share a same physical (Ethernet) network.
- VXLAN (RFC 7348) - Virtual eXtensible Local Area Network: A type of virtual network that simulates a LAN (Ethernet/L2 segment) between two hosts or more that might not belong to the same local network and might even be physically separated. For instance, it could be a local host like a personal computer linked to a cloud instance in a VPC. To achieve this, the packets from a host are encapsulated by VTEPs that are invisible for the hosts. The packet travels via this UDP tunnel to the destination, ie. the last router before the receiving host that decapsulates the packet. To the receiving host, it then looks like the packet comes directly from the host_1; running `traceroute` confirms this.

## OSI Model

| | Layer  | Protocol Data Unit (PDU) | Function
|---|---|---|---|
| 7 | Application | Data |   |
| 6 | Presentation | Data |   |
| 5 | Session | Data |   |
| 4 | Transport | Segment |   |
| 3 | Network | Packet, datagram |   |
| 2 | Data link | Frame | Transmission of data frames over physical signal (Ethernet, Wi-Fi, etc.) between two nodes |
| 1 | Physical | Bit, symbol | Transmission and reception of raw bit streams over physical medium (analogue signal) |