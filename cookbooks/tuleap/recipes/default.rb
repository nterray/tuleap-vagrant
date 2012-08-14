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

template '/etc/yum.repos.d/CentOS-Base.repo' do
  mode '0644'
  variables :php_base => node['tuleap']['php_base']
end

cookbook_file '/etc/yum.repos.d/tuleap.repo' do
  mode '0644'
end

tuleap_dependencies_for 'production' do
  action :install
end

# TODO:
# - run setup.sh ?
