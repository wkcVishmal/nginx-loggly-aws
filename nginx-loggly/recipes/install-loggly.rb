#
# Cookbook Name:: nginx-loggly
# Recipe:: install-loggly
#
# Copyright (C) 2017 Chamika Vishmal
#
# All rights reserved - Do Not Redistribute
#

loggly_rsyslog_ng 'nginx-log' do
  log_filename      '/var/log/nginx/access.log'
  loggly_token      '078dd418-0f5a-4437-a0da-03a6561c9063'
  loggly_tags        [ node.chef_environment ]
  rsyslog_selector   ':syslogtag, isequal, "nginx-log:"'
  rsyslog_tag        'nginx-log'
end