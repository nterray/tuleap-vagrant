#!/bin/sh

VBOX_VERSION="4.2.0"

# Packages clean-up
yum -y update
yum -y erase wireless-tools gtk2 libX11 hicolor-icon-theme avahi freetype bitstream-vera-fonts
yum -y clean all

# Chef install
true && curl -L http://opscode.com/chef/install.sh | bash

# Vagrant setup
yum -y install sudo
/usr/sbin/groupadd vagrant
/usr/sbin/useradd vagrant -g vagrant -G wheel
echo "vagrant"|passwd --stdin vagrant
echo "vagrant ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
mkdir /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
cd /home/vagrant/.ssh
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O authorized_keys
chown -R vagrant /home/vagrant/.ssh
echo $VBOX_VERSION >> /home/vagrant/.vbox_version
date > /etc/vagrant_box_build_time

# VirtualBox guest additions
yum -y install kernel-devel gcc
export KERN_DIR=/usr/src/kernels/`uname -r`-`uname -m`
cd /tmp
wget http://download.virtualbox.org/virtualbox/$VBOX_VERSION/VBoxGuestAdditions_$VBOX_VERSION.iso
mount -o loop VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
sh /mnt/VBoxLinuxAdditions.run --nox11
umount /mnt
rm -f VBoxGuestAdditions_$VBOX_VERSION.iso
