#!/bin/sh
# See: https://gist.github.com/2178591
# http://wiki.opscode.com/display/chef/Installing+Omnibus+Chef+Client+on+Linux+and+Mac
# http://www.virtualbox.org/manual/ch04.html#idp11962400
# http://www.if-not-true-then-false.com/2010/centos-netinstall-network-installation/
# http://www.if-not-true-then-false.com/2010/install-virtualbox-guest-additions-on-fedora-centos-red-hat-rhel/
# http://vagrantup.com/v1/docs/getting-started/index.html
# http://pyfunc.blogspot.fr/2011/11/creating-base-box-from-scratch-for.html

# Box info
VBOX_VERSION="4.1.18"
echo $VBOX_VERSION >> /home/vagrant/.vbox_version
date > /etc/vagrant_box_build_time

# Update/remove default packages
yum -y update
yum -y erase wireless-tools gtk2 libX11 hicolor-icon-theme avahi freetype bitstream-vera-fonts
yum -y clean all

# Chef (with embedded ruby)
true && curl -L http://opscode.com/chef/install.sh | bash

# Vagrant user
yum -y install sudo
/usr/sbin/groupadd vagrant
/usr/sbin/useradd vagrant -g vagrant -G wheel
echo "vagrant"|passwd --stdin vagrant
echo "vagrant ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# SSH key
mkdir /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
cd /home/vagrant/.ssh
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O authorized_keys
chown -R vagrant /home/vagrant/.ssh

# MAC : 08:00:27:46:E6:6F

kernel-devel

export KERN_DIR=/usr/src/kernels/`uname -r`-`uname -m`
sudo sh /mnt/VBoxLinuxAdditions.run --nox11

