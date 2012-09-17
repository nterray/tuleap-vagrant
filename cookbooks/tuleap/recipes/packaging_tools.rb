#
# Cookbook Name:: tuleap
# Recipe:: packaging_tools
#
# Copyright 2012, Enalean
#
# All rights reserved - Do Not Redistribute
#

package 'rpm-build'
package 'mock'
package 'make'
package 'createrepo'

group 'mock' do
  action :manage
  members node['tuleap']['packaging_user']
  append true
end

node['tuleap']['createrepos'].each do |path|
  createrepo path do
    user node['tuleap']['packaging_user']
  end
end

#   byacc
#   enscript
#   flex
#   freetype-devel
#   gcc-c++
#   gd-devel
#   httpd-devel
#   java-1.6.0-openjdk
#   krb5-devel
#   libjpeg-devel
#   libpng-devel
#   libtool
#   mysql-devel
#   MySQL-python
#   pam-devel
#   pcre-devel
#   #{php_base}-devel
#   python-devel
#   rcs
#   rpmgraph (EPEL)
