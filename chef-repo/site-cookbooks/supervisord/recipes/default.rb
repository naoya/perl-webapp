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
  action [ :enable, :start ]
end
