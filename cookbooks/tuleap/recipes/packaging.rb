#
# Cookbook Name:: tuleap
# Recipe:: packaging
#
# Copyright 2012, Enalean
#
# All rights reserved - Do Not Redistribute
#

php_base = node['tuleap']['php_base']

# Remove the production dependencies (to prevent conflict with the packages to be built)
node['tuleap']['production']['dependencies'].each do |name|
  package eval("\"#{name}\"") do
    action :purge
  end
end

# Disable official Tuleap repo (to prevent conflict with the packages to be built)
file '/etc/yum.repos.d/tuleap.repo' do
  action :delete
end

# Install the packaging required RPMs
node['tuleap']['packaging']['dependencies'].each do |name|
  package eval("\"#{name}\"") do
    action :install
  end
end

# Add the packaging user to the mock group (required for building RPMs)
group 'mock' do
  members [node['tuleap']['packaging']['user']]
  append true
end

# TODO:
# - Remove Tuleap repo
# - Setup build environment (~/rpmbuild ?)
