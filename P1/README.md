# P1 - Part 1

This directory contains the files and resources for Part 1 of the BADASS project.

## Dockerfiles

- `router_nponchon/Dockerfile`: Dockerfile for building the router image used in the GNS3 topology.
- `host_nponchon/Dockerfile`: Dockerfile for building the host image used in the GNS3 topology.

The images use a base image of `badass-frrouting`, which is built from the FRR image pulled from Quay. These are the usual images used for network simulation in GNS3 and a standard for LINUX-based network devices.
