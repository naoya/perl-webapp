#
# Cookbook Name:: base-packages
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
%w{git}.each do |pkg|
  package pkg do
    action :install
  end
end

service "iptables" do
  action [ :disable, :stop ]
end
