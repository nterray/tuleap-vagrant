#
# Cookbook Name:: tuleap
# Recipe:: packaging
#
# Copyright 2012, Enalean
#
# All rights reserved - Do Not Redistribute
#

# Remove the production dependencies (to prevent conflict with the packages to be built)
tuleap_dependencies_for 'production' do
  action :purge
end

# Disable official Tuleap repo (to prevent conflict with the packages to be built)
file node['tuleap']['repo_file'] do
  action :delete
end

# Install the packaging required RPMs
tuleap_dependencies_for 'packaging' do
  action :install
end

# Create and add the packaging user to the mock group (required for building RPMs)
user node['tuleap']['packaging']['user']

group 'mock' do
  members [node['tuleap']['packaging']['user']]
  append true
end

# Setup local yum repo for Tuleap
yum_repo 'tuleap-local' do
  action    :add
  template  true
  variables :local_repo => node['tuleap']['yum_repos']['local'],
            :enabled    => 1
  mode      '0644'
end

createrepo 'tuleap-local' do
  user node['tuleap']['packaging']['user']
  path node['tuleap']['yum_repos']['local']
end

# TODO:
# - Remove Tuleap repo
# - Setup build environment (~/rpmbuild ?)
