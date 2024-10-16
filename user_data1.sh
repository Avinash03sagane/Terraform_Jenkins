#!/bin/bash
sudo fdisk -l
sudo fdisk /dev/xvdb <<EEOF
n
p
1
2048
20971519
w
EEOF
sudo mkfs.xfs  /dev/xvdb1
sudo mkdir /var/lib/jenkins
sudo mount  /dev/xvdb1 /var/lib/jenkins
sudo useradd -m -d /var/lib/jenkins -s /bin/bash jenkins
sudo chown jenkins:jenkins /var/lib/jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum -y upgrade
sudo yum -y install java-17
sudo yum -y install jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
