FROM badass-frrouting 

RUN echo 'service integrated-vtysh-config' > /etc/frr/vtysh.conf 

RUN sed -i \
    -e 's/bgpd=no/bgpd=yes/g' \
    -e 's/ospfd=no/ospfd=yes/g' \
    -e 's/isisd=no/isisd=yes/g' \
  /etc/frr/daemons

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# what is tini?
# https://boot2podman.github.io/2019/01/02/tiny-init-minimal.html
ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]

CMD ["/usr/lib/frr/docker-start"]