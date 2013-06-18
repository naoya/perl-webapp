#
# Cookbook Name:: supervisord
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "supervisor" do
  action :install
end

service "supervisord" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

template "supervisord.conf" do
  path "/etc/supervisord.conf"
  owner "root"
  group "root"
  mode 0644
  notifies :reload, 'service[supervisord]'
end
