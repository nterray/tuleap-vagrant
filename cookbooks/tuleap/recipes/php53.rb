#
# Cookbook Name:: tuleap
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Use PHP 5.3 from CentOS repo
cookbook_file '/etc/yum.repos.d/CentOS-Base.repo' do
  source 'php53/CentOS-Base.repo'
  mode '0644'
end

package 'php53'
package 'php53-xml'
package 'java-1.6.0-openjdk'

link("/usr/share/codendi") { to '/mnt/tuleap/tuleap' }

SOURCES_DIR   = '/mnt/tuleap'
RPM_BUILD_DIR = '/home/vagrant/rpmbuild'
DEPENDENCIES  = %w(
  cvs-tuleap
  cvsgraph
  elasticsearch
  geshi
  gitolite
  highlight
  htmlpurifier
  jpgraph-tuleap
  libnss-mysql
  mailman-tuleap
  manifest
  openfire-tuleap-plugins
  php-Smarty
  php-pear
  php-pear-Auth-SASL
  php-pear-HTTP
  php-pear-HTTP-Download
  php-pear-HTTP-Header
  php-pear-Mail
  php-pear-Mail-Mbox
  php-pear-Mail-Mime
  php-pear-Mail-mimeDecode
  php-pear-Net-SMTP
  php-pear-Net-Socket
  php-pecl-apc
  php-pecl-json
  php-pecl-oci8
  php-pecl-xdebug
  php-zendframework
  sabredav
  viewvc-tuleap
)

directory "#{SOURCES_DIR}/manifest/TMP/SOURCES" do
  recursive true
end

DEPENDENCIES.each do |dependency|
  spec_file    = Dir["#{SOURCES_DIR}/#{dependency}/*.spec"].first
  source_files = Dir["#{SOURCES_DIR}/#{dependency}/*"] - [spec_file]
  rpm_file     = (dependency =~ /php-(.*)/ ? "php53-#{$1}" : dependency) + '*.rpm'
  
  source_files.each do |source_file|
    source_filename = File.basename(source_file)
    link("#{SOURCES_DIR}/manifest/TMP/SOURCES/#{source_filename}") { to source_file }
  end
  
  execute "rpmbuild -ba #{SOURCES_DIR}/#{dependency}/*.spec" do
    user 'vagrant'
  end
  
  execute "rpm -ivh --force #{RPM_BUILD_DIR}/RPMS/noarch/#{rpm_file}"
end

include_recipe 'tuleap::selinux'
include_recipe 'tuleap::iptables'

