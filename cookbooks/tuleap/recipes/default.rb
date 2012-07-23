#
# Cookbook Name:: tuleap
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file '/etc/yum.repos.d/tuleap.repo' do
  mode '0644'
end

package 'php-pecl-json'
package 'tuleap-all'

cookbook_file '/etc/sysconfig/selinux' do
  mode '0644'
end
