# Glossary

BADASS is an extremely complex project that touches a far more incredibly abyssal field of knowledge and technology than I have ever encountered at 42.

This project involves an overwhelming amount of concepts, technologies, tools, and jargon that are new to me, and that are necessary to understand in order to successfully complete the project but more importantly to understand the basics of how the Internet and computer networks work.

This glossary shall be a humble attempt at centralising and defining concepts, acronyms and technologies that I have encountered during the project.

## Definitions

All definitions are my own and may be inaccurate, incomplete or just plain wrong.

- **ACL** (Access Control Lists): Firewall rules between VLANs. Useful to open or close communication between subnetworks, like staff vs. students at 42, etc. for safety reasons, in accordance to the principle of least privileges.
- **AS** (Autonomous System): A collection of IP networks that is managed by a single administrative entity.
- **BGP** (Border Gateway Protocol): Exchanging routes between autonomous systems (like Internet-scale routing).
- **BGP EVPN** (RFC 7432): A BGP extension for Ethernet VPNs that allows for the exchange of MAC address reachability information between VTEPs in a VXLAN. This is used in P3 to allow the routers to discover the MAC addresses of the other routers in the same VXLAN, and to learn how to reach them via their IP addresses.
- **Bridge**: A bridge is a network interface that is proper to a single host, and that can be used to connect multiple network interfaces together. For instance, in this project, we have a bridge on the host that connects the physical Ethernet interface to the VXLAN interface: without the bridge, the routers in P3 would not be able to communicate between their Ethernet and VXLAN interfaces. By extension, running a VM and setting the connection to "bridged" mode means that the VM will be connected to the same bridge as the host, so that the VM will be considered as forming part of the same local network as the host, and will be able to communicate with the same devices as the host.
- **DHCP** (Dynamic Host Configuration Protocol): A protocol that automatically assigns IP addresses and other network configuration parameters to devices on a network.
- **DNS** (Domain Name System): The phonebook of the Internet. This is the service that translates a domain name, ie. a string into a corresponding IP address.
- **Ethernet** (IEEE 802.3): A standard for wired local area networks (LANs) that defines the physical and data link layers of the OSI model.
- **IS-IS** (Intermediate System to Intermediate System): A routing protocol.
- **Leaf**: see VTEP.
- **MAC** (Media Access Control): This is the unique identifier for a network interface at the L2 level. It is a 48-bit address, usually represented as 6 groups of 2 hexadecimal digits separated by colons (e.g., 00:1A:2B:3C:4D:5E). Manufacturers usually have a specific range of MAC addresses that they use for the devices they produce, so the first 3 groups of 2 hexadecimal digits (the OUI, Organizationally Unique Identifier) can be used to identify the manufacturer of the device. For instance, the OUI 00:1A:2B is assigned to Apple Inc., so any device with a MAC address starting with 00:1A:2B is likely an Apple device. The MAC address is used for communication within a local network (L2) and is not routable across the Internet.
- **MPLS** (Multiprotocol Label Switching): A networking protocol that directs data from one network segment to the next based on labels rather than network addresses. Not used in this project, but it seems to be a more efficient way to route packets in large networks and to be used in data centers and service provider networks.
- **Multicast**: A communication method where a single source sends data to multiple destinations simultaneously using a single transmission instead of sending separate unicast messages to each destination. In this project, this is used in P2 in that all the routers listen to the same multicast IP to discover all the other members of the same VXLAN.
- **OSPF** (Open Shortest Path First): A routing protocol.
- **RR** (Route Reflector): A device that is used to reflect routing information to other routers in the same autonomous system. The purpose of a RR is _not_ to handle packets directly, although they might physically transit through it via the Ethernet interface for instance. Instead, they are coordinating the exchange of routing information between the other routers (VTEPs or Leaves) in the same VXLAN.
- **Route types**: The BGP EVPN RFC defines several route types that are used to exchange different types of information between VTEPs in a VXLAN. For instance, the Type 2 route is used to exchange MAC address reachability information, while the Type 3 route is used to exchange IP address reachability information. This is observable in the P3, where the routers first establish Type 2 routes to learn the MAC addresses of the other routers in the same VXLAN, then establish Type 3 routes to learn the IP addresses of the hosts behind the other routers in the same VXLAN.
- **Static vs. dynamic** mode: In static mode, the routers have the IPs of the other routers members of the same VXLAN hardcoded. In dynamic mode, however, all the routers are using groups to communicate with all the others: they listen to the same multicast IP (range 224.0.0.0 to 239.255.255.255) to discover all the other members. This avoid unnecessary broadcast or hardcoded IPs.
- **VNI** (VXLAN Network Identifier): The identifier for a specific segment in a VXLAN.
- **VTEP** (VXLAN tunnel endpoints): Entry and exit points for VXLAN. These are the endpoints where Ethernet frames are encapsulated into UDP packets and decapsulated back into Ethernet frames before travelling to their destination. When they have reached the destination VTEP, they are decapsulated back to Ethernet frames and delivered to the remote host.
- **VLAN** (Virtual Local Area Network): A physical network segmented into several logical subnetworks at the L2 level via managed switches. This is a typical infrastructure for an office or a school where all the hosts share a same physical (Ethernet) network.
- **VXLAN** (RFC 7348) - Virtual eXtensible Local Area Network: A type of virtual network that simulates a LAN (Ethernet/L2 segment) between two hosts or more that might not belong to the same local network and might even be physically separated. For instance, it could be a local host like a personal computer linked to a cloud instance in a VPC. To achieve this, the packets from a host are encapsulated by VTEPs that are invisible for the hosts. The packet travels via this UDP tunnel to the destination, ie. the last router before the receiving host that decapsulates the packet. To the receiving host, it then looks like the packet comes directly from the host_1; running `traceroute` confirms this.

## OSI Model

| | Layer  | Protocol Data Unit (PDU) | Function
|---|---|---|---|
| 7 | Application | Data | The various applications that use the network: HTTP, DNS, FTP, SSH, SMTP |
| 6 | Presentation | Data | Handling the representation of data: JSON, ASCII, TLS/SSL |
| 5 | Session | Data | Maintenance of session state such as TCP connections |
| 4 | Transport | Segment | End-to-end communication: the delivery of data between applications to the exact port/service |
| 3 | Network | Packet, datagram | The routing layer: how a packet is forwarded from source to destination IP by one or multiple routers |
| 2 | Data link | Frame | Transmission of data frames over physical signal (Ethernet, Wi-Fi, etc.) between two nodes (MAC addresses) |
| 1 | Physical | Bit, symbol | Transmission and reception of raw bit streams over physical medium (analogue signal) |
