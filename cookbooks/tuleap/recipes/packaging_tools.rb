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
