#
# Cookbook Name:: tuleap
# Recipe:: development
#
# Copyright 2012, Enalean
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'tuleap::selinux'
include_recipe 'tuleap::iptables'

# Remove the tuleap production package (to prevent conflict with the development version)
node['tuleap']['production']['dependencies'].each do |name|
  package name do
    action :purge
  end
end

# Install the development tools
node['tuleap']['development']['dependencies'].each do |name|
  package name do
    action :install
  end
end

user node['tuleap']['development']['user'] do
  uid node['tuleap']['development']['uid']
  gid node['tuleap']['development']['gid']
end

# Use the development source tree for deployment
link node['tuleap']['production']['base_dir'] do
  to node['tuleap']['repositories']['local']['tuleap']
end

# TODO:
# - Remove existing tuleap install ?
# - Remove Tuleap repo ?
