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

tuleap_dependencies_for 'production' do
  action :purge
  only_if { File.exists? '/etc/yum.repos.d/tuleap-dev.repo' }
end

package 'php53-common' do
  action :purge
end

yum_repo 'tuleap-dev' do
  action :remove
end

yum_repo 'epel' do
  action :remove
end

file '/etc/yum.repos.d/epel-testing.repo' do
  action :delete
end

yum_repo 'CentOS-Base' do
  action :add
  template true
  mode '0644'
  variables :php_base => node['tuleap']['php_base'],
            :mirror   => node['tuleap']['centos_mirror']
end

yum_repo 'tuleap' do
  action :add
  mode '0644'
end

link '/usr/share/codendi' do
  action :delete
  only_if 'test -L /usr/share/codendi'
end

tuleap_dependencies_for 'production' do
  action :install
end

# TODO:
# - run setup.sh ?
