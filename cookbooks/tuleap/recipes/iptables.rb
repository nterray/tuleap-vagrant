#
# Cookbook Name:: tuleap
# Recipe:: iptables
#
# Copyright 2012, Enalean
#
# All rights reserved - Do Not Redistribute
#

## Configure iptables for Tuleap
cookbook_file '/etc/sysconfig/iptables' do
  mode '0600'
end
