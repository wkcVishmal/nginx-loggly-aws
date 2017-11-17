#
# Cookbook Name:: nginx-loggly
# Recipe:: install-loggly
#
# Copyright (C) 2017 Chamika Vishmal
#
# All rights reserved - Do Not Redistribute
#

execute "download loggly" do
  command "curl -O https://www.loggly.com/install/configure-nginx.sh"
  user "root"
  cwd "/"
  action :run
end

execute "configure loggly" do
  command "sudo bash configure-nginx.sh -a chamika -t 078dd418-0f5a-4437-a0da-03a6561c9063 -u chamika -p Wakwella.92"
  user "root"
  cwd "/"
  action :run
end