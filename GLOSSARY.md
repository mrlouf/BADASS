# Glossary

BADASS is an extremely complex project that touches a far more incredibly abyssal field of knowledge and technology than I have ever encountered at 42.

This project involves an overwhelming amount of concepts, technologies, tools, and jargon that are new to me, and that are necessary to understand in order to successfully complete the project but more importantly to understand the basics of how the Internet and computer networks work.

This glossary shall be a humble attempt at centralising and defining concepts, acronyms and technologies that I have encountered during the project.

## Definitions

All definitions are my own and may be inaccurate, incomplete or just plain wrong.

- **ACL** (Access Control Lists): Firewall rules between VLANs. Useful to open or close communication between subnetworks, like staff vs. students at 42, etc. for safety reasons, in accordance to the principle of least privileges.
- **AS** (Autonomous System):
- **BGP** (Border Gateway Protocol): Exchanging routes between autonomous systems (like Internet-scale routing)
- **BGP EVPN** (RFC 7432)
- **Bridge**:
- **DHCP**:
- **DNS** (Domain Name System): The phonebook of the Internet. This is the service that translates a domain name, ie. a string into a corresponding IP address.
- **Ethernet**:
- **IS-IS**
- **Leaf**: see VTEP.
- **MAC** address:
- **MPLS**
- **Multicast**
- **OSPF** (Open Shortest Path First):
- **RR** (Route Reflection):
- **Route types**:
- **Static vs. dynamic** mode: In static mode, the routers have the IPs of the other routers members of the same VXLAN hardcoded. In dynamic mode, however, all the routers are using groups to communicate with all the others: they listen to the same multicast IP (range 224.0.0.0 to 239.255.255.255) to discover all the other members. This avoid unnecessary broadcast or hardcoded IPs.
- **VNI** (VXLAN Network Identifier): The identifier for a specific segment in a VXLAN.
- **VTEP** (VXLAN tunnel endpoints): Entry and exit points for VXLAN. These are the endpoints where Ethernet frames are encapsulated into UDP packets and decapsulated back into Ethernet frames before travelling to their destination. When they have reached the destination VTEP, they are decapsulated back to Ethernet frames and delivered to the remote host.
- **VLAN** (Virtual Local Area Network): A physical network segmented into several logical subnetworks at the L2 level via managed switches. This is a typical infrastructure for an office or a school where all the hosts share a same physical (Ethernet) network.
- **VXLAN** (RFC 7348) - Virtual eXtensible Local Area Network: A type of virtual network that simulates a LAN (Ethernet/L2 segment) between two hosts or more that might not belong to the same local network and might even be physically separated. For instance, it could be a local host like a personal computer linked to a cloud instance in a VPC. To achieve this, the packets from a host are encapsulated by VTEPs that are invisible for the hosts. The packet travels via this UDP tunnel to the destination, ie. the last router before the receiving host that decapsulates the packet. To the receiving host, it then looks like the packet comes directly from the host_1; running `traceroute` confirms this.

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