#
# Cookbook Name:: tuleap
# Recipe:: default
#
# Copyright 2012, Enalean
#
# All rights reserved - Do Not Redistribute
#

script 'Build Tuleap (S)RPMS' do
  interpreter 'bash'
  user 'root' #node['tuleap']['packaging']['user']
  cwd node['tuleap']['repositories']['local']['manifest']
  code <<-SH
    ./build --php-base=#{node['tuleap']['php_base']}
  SH
end
