#
# Cookbook Name:: tuleap
# Recipe:: iptables
#
# Copyright 2012, Enalean
#
# All rights reserved - Do Not Redistribute
#

cookbook_file '/etc/sysconfig/iptables' do
  mode '0600'
end
