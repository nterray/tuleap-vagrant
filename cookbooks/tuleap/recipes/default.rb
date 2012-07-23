#
# Cookbook Name:: tuleap
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Disable PHP from CentOS repository
cookbook_file '/etc/yum.repos.d/CentOS-Base.repo' do
  mode '0644'
end

# Add Tuleap repository
cookbook_file '/etc/yum.repos.d/tuleap.repo' do
  mode '0644'
end

# Install PHP + Tuleap from Tuleap repository
package 'php-pecl-json'
package 'tuleap-all'

# Disable SELinux
cookbook_file '/etc/sysconfig/selinux' do
  mode '0644'
end

# Open port 80
cookbook_file '/etc/sysconfig/iptables' do
  mode '0600'
end
