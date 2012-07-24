#
# Cookbook Name:: tuleap
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Use PHP 5.3 from CentOS repo
cookbook_file '/etc/yum.repos.d/CentOS-Base.repo' do
  source 'php53/CentOS-Base.repo'
  mode '0644'
end

package 'php53'
package 'java-1.6.0-openjdk'

# Disable SELinux
cookbook_file '/etc/selinux/config' do
  source 'selinux'
  mode '0644'
end

# Open port 80
cookbook_file '/etc/sysconfig/iptables' do
  mode '0600'
end
