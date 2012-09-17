#
# Cookbook Name:: tuleap
# Recipe:: build
#
# Copyright 2012, Enalean
#
# All rights reserved - Do Not Redistribute
#

# execute 'make clone' do
#   user node['tuleap']['packaging_user']
#   cwd  node['tuleap']['manifest_dir']
# end

execute 'make specs' do
  user node['tuleap']['packaging_user']
  cwd  node['tuleap']['manifest_dir']
end

case node['tuleap']['build_platforms']
when 'all'
  platforms = %w(centos/5/i386
                 centos/5/i386-php53
                 centos/5/SRPMS
                 centos/5/x86_64
                 centos/5/x86_64-php53)
when 'current'
  arch      = `uname -m`.strip
  php_base  = node['tuleap']['php_base'] == 'php53' ? '-php53' : ''
  platforms = "centos-5-#{arch}#{php_base}"
else
  raise "Expected node['tuleap']['build_plateforms'] to be one of {all|current}, but was #{node['tuleap']['build_plateforms']}"
end

execute "make PLATEFORMS='#{platforms}' HOME=/home/vagrant" do
  user node['tuleap']['packaging_user']
  cwd  node['tuleap']['manifest_dir']
end
