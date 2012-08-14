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
file '/etc/yum.repos.d/tuleap.repo' do
  action :delete
end

# Install the packaging required RPMs
tuleap_dependencies_for 'packaging' do
  action :install
end

# Add the packaging user to the mock group (required for building RPMs)
group 'mock' do
  members [node['tuleap']['packaging']['user']]
  append true
end

# TODO:
# - Remove Tuleap repo
# - Setup build environment (~/rpmbuild ?)
