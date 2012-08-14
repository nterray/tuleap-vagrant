default['tuleap']['php_base'] = 'php'
default['tuleap']['repo_file'] = '/etc/yum.repos.d/tuleap.repo'

default['tuleap']['repositories']['remote']['stable']   = 'gitolite@tuleap.net:tuleap/tuleap/stable.git'
default['tuleap']['repositories']['remote']['dev']      = 'gitolite@tuleap.net:tuleap/tuleap/dev.git'
default['tuleap']['repositories']['remote']['manifest'] = 'gitolite@tuleap.net:tuleap/deps/manifest.git'
default['tuleap']['repositories']['local']['tuleap']    = '/mnt/tuleap/tuleap'
default['tuleap']['repositories']['local']['manifest']  = '/mnt/tuleap/manifest'

default['tuleap']['production']['base_dir'] = '/usr/share/codendi'
default['tuleap']['production']['dependencies'] = %w(
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
  #{php_base}-pear
  #{php_base}-pear-Auth-SASL
  #{php_base}-pear-HTTP
  #{php_base}-pear-HTTP-Download
  #{php_base}-pear-HTTP-Header
  #{php_base}-pear-Mail
  #{php_base}-pear-Mail-Mbox
  #{php_base}-pear-Mail-Mime
  #{php_base}-pear-Mail-mimeDecode
  #{php_base}-pear-Net-SMTP
  #{php_base}-pear-Net-Socket
  #{php_base}-pecl-apc
  #{php_base}-pecl-json
  #{php_base}-pecl-oci8
  #{php_base}-pecl-xdebug
  #{php_base}-Smarty
  #{php_base}-zendframework
  sabredav
  tuleap
  tuleap-all
  viewvc-tuleap
)

default['tuleap']['development']['base_dir'] = '/mnt/tuleap'
default['tuleap']['development']['user'] = 'tuleap-dev'
default['tuleap']['development']['dependencies'] = %w()

default['tuleap']['packaging']['base_dir'] = '~/rpmbuild'
default['tuleap']['packaging']['user'] = default['tuleap']['development']['user']
default['tuleap']['packaging']['dependencies'] = %w(
  byacc
  createrepo
  enscript
  flex
  freetype-devel
  gcc-c++
  gd-devel
  httpd-devel
  java-1.6.0-openjdk
  krb5-devel
  libjpeg-devel
  libpng-devel
  libtool
  make
  mock
  mysql-devel
  MySQL-python
  pam-devel
  pcre-devel
  #{php_base}
  #{php_base}-devel
  #{php_base}-gd
  #{php_base}-mbstring
  #{php_base}-mysql
  #{php_base}-process
  #{php_base}-soap
  #{php_base}-xml
  python-devel
  rcs
  rpm-build
)
