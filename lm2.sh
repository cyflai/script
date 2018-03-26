#!/bin/bash -uxe

## bash <(curl -s https://raw.githubusercontent.com/cyflai/script/master/lm2.sh)

yum remove -y docker docker-common docker-selinux docker-engine
yum install -y yum-utils device-mapper-persistent-data lvm2 wget ntp
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce
sed -i --follow-symlinks 's/^SELINUX=.*/SELINUX=disabled/g' /etc/sysconfig/selinux && cat /etc/sysconfig/selinux
sudo sed -i s/SELINUX=enforcing/SELINUX=disabled/g /etc/selinux/config
systemctl disable firewalld && systemctl stop firewalld
ntpdate 0.centos.pool.ntp.org
sysctl -w vm.max_map_count=262144
echo "vm.max_map_count=262144" >> /etc/sysctl.conf
chkconfig ntpd on
service ntpd start
systemctl start docker
systemctl enable docker
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1
mkdir -p /opt/lumada
cd /opt/lumada

#full product
wget https://gitlab.hds-cloudconnect.com:8443/sku-2.0.0.98.tar.gz --no-check-certificate
tar xvf sku-2.0.0.98.tar.gz
2.0.0.98/bin/install

#post installation
cp /opt/Lumada/bin/sku.service /etc/systemd/system/.
sed -i 's/hci/lumada/g' /etc/systemd/system/sku.service
sudo systemctl enable sku.service
sudo systemctl start sku.service

#remove setup
#systemctl stop lumada
#docker rm $(docker ps -a -q)
#rm -rf 2.0.0.98 bin cli config data doc log plugins retired temp
