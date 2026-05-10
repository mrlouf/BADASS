#!/bin/bash

# Ajouter user au groupe wireshark
sudo usermod -aG wireshark $USER

# Donner les permissions à dumpcap
sudo chmod +x /usr/bin/dumpcap
sudo setcap cap_net_raw,cap_net_admin=eip /usr/bin/dumpcap

# Recharger les groupes SANS reboot
newgrp wireshark

# Kill wireshark pour forcer le changement
sudo pkill -u $USER wireshark