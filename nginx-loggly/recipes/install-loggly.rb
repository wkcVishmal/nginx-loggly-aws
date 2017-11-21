#
# Cookbook Name:: nginx-loggly
# Recipe:: install-loggly
#
# Copyright (C) 2017 Chamika Vishmal
#
# All rights reserved - Do Not Redistribute
#

# execute "download loggly" do
#   command "curl -O https://www.loggly.com/install/configure-nginx.sh"
#   user "root"
#   cwd "/"
#   action :run
# end
#
# execute "configure loggly" do
#   command "sudo bash configure-nginx.sh -a chamika -t 078dd418-0f5a-4437-a0da-03a6561c9063 -u chamika -p Wakwella.92"
#   user "root"
#   cwd "/"
#   action :run
# end

include_recipe "rsyslog"

apt_update "update"

# apt_package 'python-setuptools' do
#   action :install
# end

command "python setup-tools install" do
  command "sudo apt-get install python-setuptools"
  action :run
end

# Taken from https://www.loggly.com/docs/configure-syslog-script
execute "install loggly" do
  command "wget -q -O - https://www.loggly.com/install/configure-syslog.py | sudo python - setup --yes --auth 078dd418-0f5a-4437-a0da-03a6561c9063 --account chamika"
  action :run
  not_if { node[:loggly][:auth].empty? }
end

template "/etc/rsyslog.d/21-nginx-loggly.conf" do
  source "loggly-nginx.conf.erb"
  notifies :restart, "service[rsyslog]"
end
