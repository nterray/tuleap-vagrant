#
# Cookbook Name:: tuleap
# Recipe:: rpm
#
# Copyright 2012, Enalean
#
# All rights reserved - Do Not Redistribute
#

# Remove existing manual install
link node['tuleap']['install_dir'] do
  action :delete
  only_if "test -L #{node['tuleap']['install_dir']}"
end

# Set up common stuff
include_recipe 'tuleap::base'

script 'yum clean all' do
  interpreter 'bash'
  code <<-SH
    yum clean all
    yum clean expire-cache
  SH
end

# Install JSON PECL extension for PHP (needed by Tuleap):
#   - The PHP 5.1 version is php-pecl-json
#   - The PHP 5.3 version is included in php53-common
package('php-pecl-json') { only_if { node['tuleap']['php_base'] == 'php' } }

# Install Tuleap RPM
if node['tuleap']['php_base'] == 'php53'
  package 'tuleap-all-php53'
else
  package 'tuleap-all'
end

cookbook_file '/root/setup_runner.sh'
# execute 'sh /root/setup_runner.sh' do
#   user 'root'
#   cwd '/root'
# end
