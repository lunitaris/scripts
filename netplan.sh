#!/bin/bash
sudo apt update
clear

sudo apt install net-tools -y 
ifconfig

sleep 2
echo "--------------------------------------------------------"

# Demande des informations à l'utilisateur
read -p "Nom de l'interface réseau (ex: eth0) : " interface
read -p "Adresse IP statique (ex: 192.168.3.10/24) : " ip_address
read -p "Passerelle (gateway) (ex: 192.168.3.1) : " gateway
read -p "Serveur DNS (ex: 8.8.8.8,8.8.4.4) : " dns

# Génération du fichier Netplan avec la syntaxe mise à jour
cat <<EOF | sudo tee /etc/netplan/01-netcfg.yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    $interface:
      dhcp4: no
      addresses:
        - $ip_address
      routes:
        - to: default
          via: $gateway
      nameservers:
        addresses: [$dns]
EOF

# Applique la configuration
sudo netplan apply

echo "La configuration réseau statique a été appliquée."
