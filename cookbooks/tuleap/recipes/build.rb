#
# Cookbook Name:: tuleap
# Recipe:: build
#
# Copyright 2012, Enalean
#
# All rights reserved - Do Not Redistribute
#

script 'Build RPM packages for Tuleap and its dependencies from local git repository' do
  interpreter 'bash'
  user 'root' #node['tuleap']['build_user']
  cwd node['tuleap']['manifest_dir']
  code <<-SH
    make specs
    make
  SH
end
