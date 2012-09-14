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
yum_repo 'CentOS-Base' do
  action :add
  template true
  mode '0644'
  variables :php_base => node['tuleap']['php_base'],
            :mirror   => node['tuleap']['mirror']
end

# Install PHP
package node['tuleap']['php_base']
