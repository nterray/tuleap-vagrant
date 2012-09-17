#
# Cookbook Name:: tuleap
# Recipe:: base
#
# Copyright 2012, Enalean
#
# All rights reserved - Do Not Redistribute
#

package 'yum-utils'

# Disable SElinux
cookbook_file '/etc/selinux/config' do
  source 'selinux'
  mode '0644'
end

# Configure iptables for Tuleap
cookbook_file '/etc/sysconfig/iptables' do
  mode '0600'
end

# Remove previously installed PHP packages that are incompatible
%w(php php53).each do |php_base|
  package "#{php_base}-common" do
    action :purge
    only_if { php_base != node['tuleap']['php_base'] }
  end
end

# Customize the default CentOS repo to exclude incompatible PHP packages
template "/etc/yum.repos.d/CentOS-Base.repo" do
  mode '0644'
  variables :php_base => node['tuleap']['php_base'],
            :mirror   => node['tuleap']['mirror']
end

# Install PHP
package node['tuleap']['php_base']

# Set up EPEL repo (disabled by default)
include_recipe 'yum::epel'
disable_yum_repository 'epel'
disable_yum_repository 'epel-testing'

# Set up Tuleap stable repo
tuleap_yum_repository 'stable' do
  description 'Official Releases'
  url         'https://tuleap.net/file/pub/tuleap/yum/tuleap/4.0/$basearch/'
end

# Set up Tuleap development repo
tuleap_yum_repository 'dev' do
  description 'Main Development Branch'
  url         'ftp://ci.tuleap.net/yum/tuleap/dev/$basearch'
end

# Set up Tuleap local repo
php53 = (node['tuleap']['php_base'] == 'php53' ? '-php53' : '')

tuleap_yum_repository 'local' do
  description 'Local Repository'
  url         "file:///mnt/tuleap/manifest/repos/centos/5/$basearch#{php53}"
end

epel_package 'git'
epel_package 'perl-HTML-Template'

remote_rpm 'openfire' do
  source 'http://download.igniterealtime.org/openfire/openfire-3.7.1-1.i386.rpm'
end
