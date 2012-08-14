#
# Cookbook Name:: tuleap
# Recipe:: default
#
# Copyright 2012, Enalean
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'tuleap::selinux'
include_recipe 'tuleap::iptables'

# Disable PHP from CentOS repository
cookbook_file '/etc/yum.repos.d/CentOS-Base.repo' do
  mode '0644'
end

cookbook_file '/etc/yum.repos.d/tuleap.repo' do
  mode '0644'
end

node['tuleap']['production']['dependencies'].each do |name|
  package name
end

# TODO:
# - run setup.sh ?
