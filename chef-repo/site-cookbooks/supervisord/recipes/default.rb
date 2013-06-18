#
# Cookbook Name:: supervisord
# Recipe:: default

rpmfile = "supervisor-3.0a12-2.el6.noarch.rpm"
cookbook_file "#{Chef::Config[:file_cache_path]}/#{rpmfile}" do
  mode 00644
end

package "supervisor" do
  source "#{Chef::Config[:file_cache_path]}/#{rpmfile}"
  action :install
end

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
