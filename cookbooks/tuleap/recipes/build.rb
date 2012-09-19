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
  platforms = %w(centos-5-i386
                 centos-5-i386-php53
                 centos-5-x86_64
                 centos-5-x86_64-php53)
when 'current'
  arch      = `uname -m`.strip
  php_base  = node['tuleap']['php_base'] == 'php53' ? '-php53' : ''
  platforms = "centos-5-#{arch}#{php_base}"
else
  raise "Expected node['tuleap']['build_plateforms'] to be one of {all|current}, but was #{node['tuleap']['build_plateforms']}"
end

execute "su -l vagrant -c 'make -C #{node['tuleap']['manifest_dir']} PLATEFORMS=\"#{platforms}\"'" #do # HOME=/home/vagrant
  # user node['tuleap']['packaging_user']
  # group 'mock'
  # cwd  node['tuleap']['manifest_dir']
# end

# script 'build tuleap dependencies' do
#   user node['tuleap']['packaging_user']
#   cwd  node['tuleap']['manifest_dir']
#   code <<-SHELL
#          make PLATEFORMS=#{platforms}
#        SHELL
# end
# 
# repo_path = "/mnt/tuleap/manifest/repos/centos/5/x86_64#{php_base}"
# 
# script 'build tuleap' do
#   user node['tuleap']['packaging_user']
#   cwd  '/mnt/tuleap/tuleap/tools/rpm'
#   code <<-SHELL
#          make PHP_BASE=#{php_base ? 'php53' : 'php'}
#          mv /home/vagrant/rpmbuild/RPMS/noarch/* #{repo_path}
#          createrepo #{repo_path}
#          sudo yum clean all
#          sudo yum clean expire-cache
#        SHELL
# end
