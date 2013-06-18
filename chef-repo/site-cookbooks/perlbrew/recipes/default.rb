#
# Cookbook Name:: perlbrew
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
bash "perlbrew" do
  user node['perl']['user']['name']
  cwd node['perl']['user']['home']
  environment "HOME" => node['perl']['user']['home']

  code <<-EOC
    curl -kL http://install.perlbrew.pl | bash
  EOC

  creates node['perl']['user']['home'] + "/perl5/perlbrew/bin/perlbrew"
end

bash "perl" do
  home = node['perl']['user']['home']
  path = home + "/perl5/perlbrew/perls/perl-" + node['perl']['version'] + "/bin/perl"
  user node['perl']['user']['name']
  cwd home
  environment "HOME" => home

  code <<-EOC
    source ~/perl5/perlbrew/etc/bashrc
    perlbrew install #{node['perl']['version']}
    perlbrew switch #{node['perl']['version']}
    curl -L http://cpanmin.us | perl - App::cpanminus
  EOC

  not_if { File.exists?(path) }
end
