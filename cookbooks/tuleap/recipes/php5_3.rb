#
# Cookbook Name:: tuleap
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# %w(php53 )
package 'php53'
package 'java-1.6.0-openjdk'

directory '/usr/share/codendi' do
  action :delete
  recursive true
end

link '/usr/share/codendi' do
  to '/tuleap'
end


# Disable SELinux
cookbook_file '/etc/selinux/config' do
  source 'selinux'
  mode '0644'
end

# Open port 80
cookbook_file '/etc/sysconfig/iptables' do
  mode '0600'
end
