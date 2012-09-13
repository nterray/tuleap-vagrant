#
# Cookbook Name:: tuleap
# Recipe:: git
#
# Copyright 2012, Enalean
#
# All rights reserved - Do Not Redistribute
#

# Proceed to a normal RPM deployment
include_recipe 'tuleap::rpm_deployment'

# Then remove the Tuleap RPM package, but keep the configuration files
if node['tuleap']['php_base'] == 'php53'
  package('tuleap-php53') { action :remove }
else
  package('tuleap') { action :remove }
end

# Symlink the local git repository
link '/usr/share/codendi' do
  to '/mnt/tuleap/tuleap'
  action :create
end
