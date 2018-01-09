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
wget https://gitlab.hds-cloudconnect.com:8443/Lumada-2.0.0.213.tar.gz --no-check-certificate
tar xvf Lumada-2.0.0.213.tar.gz 
2.0.0.213/bin/install
