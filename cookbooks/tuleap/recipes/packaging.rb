#
# Cookbook Name:: tuleap
# Recipe:: packaging
#
# Copyright 2012, Enalean
#
# All rights reserved - Do Not Redistribute
#

# Remove the production dependencies (to prevent conflict with the packages to be built)
node['tuleap']['production']['dependencies'].each do |name|
  package name do
    action :purge
  end
end

# Install the packaging required RPMs
node['tuleap']['packaging']['dependencies'].each do |name|
  package name
end

# Add the packaging user to the mock group (required for building RPMs)
group 'mock' do
  members [node['tuleap']['packaging']['user']]
  append true
end

# TODO:
# - Remove Tuleap repo
# - Setup build environment (~/rpmbuild ?)
