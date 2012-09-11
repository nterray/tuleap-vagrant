#
# Cookbook Name:: tuleap
# Recipe:: rpm
#
# Copyright 2012, Enalean
#
# All rights reserved - Do Not Redistribute
#

# Remove YUM repos that are not compatible with Tuleap's one
package('epel-release') { action :purge }
yum_repo('epel') { action :remove }
file('/etc/yum.repos.d/epel-testing.repo') { action :delete }
%w(stable dev local).each do |repo_name|
  if repo_name != node['tuleap']['yum_repo']
    yum_repo("tuleap-#{repo_name}") { action :remove }
  end
end

# Set up common stuff
include_recipe 'tuleap::base'

# Set up the Tuleap YUM repo
repo_name = node['tuleap']['yum_repo']
yum_repo "tuleap-#{repo_name}" do
  action :add
  template true
  source 'tuleap.repo.erb'
  variables :baseurl  => node['tuleap']['yum_repos'][repo_name],
            :php_base => node['tuleap']['php_base']
  mode '0644'
end

# Ensure local repo has metadata
# if node['tuleap']['yum_repo'] == 'local'
#   require 'uri'
#   createrepo URI.parse(node['tuleap']['yum_repos']['local']['baseurl']).path
# end

# Remove existing manual install
link node['tuleap']['install_dir'] do
  action :delete
  only_if "test -L #{node['tuleap']['install_dir']}"
end

# Install JSON PECL extension for PHP (needed by Tuleap):
#   - The PHP 5.1 version is php-pecl-json
#   - The PHP 5.3 version is included in php53-common
package('php-pecl-json') { only_if { node['tuleap']['php_base'] == 'php' } }

# Install Tuleap RPM
package 'tuleap-all'
