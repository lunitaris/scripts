#!/bin/bash
## Set netplan network configuraion to a static IP.

# NETCARD=ip route show default | awk '{print $5}'


sudo tee /etc/netplan/50-cloud-init.yaml<<EOF
network:
  version: 2
  ethernets:
    enp0s3:
      dhcp4: no
      addresses:
        - 192.168.3.130/24
      gateway4: 192.168.3.1
      nameservers:
        addresses:
          - 192.168.3.1
          - 1.1.1.1
EOF
