#
# Cookbook Name:: tuleap
# Recipe:: local_repos
#
# Copyright 2012, Enalean
#
# All rights reserved - Do Not Redistribute
#

node['tuleap']['createrepos'].each do |path|
  createrepo path do
    user node['tuleap']['packaging_user']
  end
end