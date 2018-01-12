#!/bin/bash -uxe

## bash <(curl -s https://raw.githubusercontent.com/cyflai/script/master/cos-lm2.sh)

sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config
sudo sysctl -w vm.max_map_count=262144
sudo echo "vm.max_map_count=262144" >> /etc/sysctl.conf

mkdir -p /opt/lumada
cd /opt/lumada

#full product
wget https://gitlab.hds-cloudconnect.com:8443/sku-2.0.0.98.tar.gz --no-check-certificate
tar xvf sku-2.0.0.98.tar.gz
2.0.0.98/bin/install

#core installation
#wget https://gitlab.hds-cloudconnect.com:8443/Lumada-2.0.0.213.tar.gz --no-check-certificate
#tar xvf Lumada-2.0.0.213.tar.gz 
#2.0.0.213/bin/install
