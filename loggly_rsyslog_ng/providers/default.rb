#
# Cookbook Name:: loggly_rsyslog_ng
# Provider:: default
#
# Author: Matt Veitas mveitas@gmail.com
# Author: Kostiantyn Lysenko gshaud@gmail.com
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

def whyrun_supported?
  true
end

use_inline_resources

action :install do

  if new_resource.rsyslog_install
    %w{rsyslog rsyslog-gnutls}.each { |pkg| package pkg }
  end

  # define rsyslog service
  service 'rsyslog' do
    supports :status => true, :start => true, :stop => true, :restart => true, :reload => true
    action :nothing
  end

  # Create log file directory if it's not exist
  dirname = ::File.dirname(new_resource.log_filename)

  directory dirname do
    recursive true
    not_if { ::File.exists?(dirname) }
  end
  
  # Create log file if it's not exist
  file new_resource.log_filename do
    action :touch
    owner new_resource.log_owner
    group new_resource.log_group
    not_if { ::File.exists?(new_resource.log_filename) }
  end
  
  if new_resource.loggly_tls_certs_install
    loggly_rsyslog_ng_tls 'Install loggly TLS certificate' do
      cert_name new_resource.loggly_tls_name
      cert_path new_resource.loggly_tls_path
    end
  end

  if new_resource.loggly_port
    loggly_port = new_resource.loggly_port
  else
    loggly_port = new_resource.rsyslog_tls_enable ? 6514 : 514
  end

  rsyslog_config = new_resource.rsyslog_config ? new_resource.rsyslog_config : "/etc/rsyslog.d/22-loggly-#{new_resource.name}.conf"
  rsyslog_ruleset = new_resource.rsyslog_ruleset ? new_resource.rsyslog_ruleset : new_resource.name
  rsyslog_tag = new_resource.rsyslog_tag ? new_resource.rsyslog_tag : new_resource.name

  uniq_name = new_resource.log_filename.gsub('/','-')
  
  # Add imfile module
  unless new_resource.rsyslog_imfile_module_source
    imfile_module_source = RSyslog::version_76_plus? ? 'rsyslog7_modules_imfile.conf.erb' : 'rsyslog5_modules_imfile.conf.erb'
  else
    imfile_module_source = new_resource.rsyslog_imfile_module_source
  end

  template '/etc/rsyslog.d/01-module-imfile.conf' do
    cookbook new_resource.cookbook
    source imfile_module_source
    variables({
      :rsyslog_input_file_poll_interval => new_resource.rsyslog_input_file_poll_interval
              })
    only_if { new_resource.rsyslog_imfile_module }
  end

  # main loggly template
  unless new_resource.source
    rsyslog_loggly_config_template = RSyslog::version_76_plus? ? 'rsyslog7_loggly.conf.erb' : 'rsyslog5_loggly.conf.erb'
  else
    rsyslog_loggly_config_template = new_resource.source
  end
  
  template rsyslog_config do
    source rsyslog_loggly_config_template
    cookbook new_resource.cookbook
    owner 'root'
    group 'root'
    mode 0644
    variables({
      :log_filename => new_resource.log_filename,
      :uniq_name => uniq_name,          
      :rsyslog_tls_enable => new_resource.rsyslog_tls_enable,
      :rsyslog_bundled_tls_enable => new_resource.rsyslog_bundled_tls_enable,
      :rsyslog_selector => new_resource.rsyslog_selector,
      :rsyslog_tag => rsyslog_tag,
      :rsyslog_ruleset => rsyslog_ruleset,
      :loggly_tls_name => new_resource.loggly_tls_name,
      :loggly_tls_path => new_resource.loggly_tls_path,
      :loggly_host => new_resource.loggly_host,
      :loggly_port => loggly_port,
      :loggly_tags => new_resource.loggly_tags.nil? || new_resource.loggly_tags.empty? ? '' : "tag=\\\"#{new_resource.loggly_tags.join("\\\" tag=\\\"")}\\\"",
      :loggly_token => new_resource.loggly_token
    })
    notifies :restart, "service[rsyslog]", :delayed
  end
end

action :uninstall do

  # define rsyslog service
  service 'rsyslog' do
    supports :status => true, :start => true, :stop => true, :restart => true, :reload => true
    action :nothing
  end

  file new_resource.rsyslog_config do
    action :delete
    notifies :restart, 'service[rsyslog]', :delayed
  end
end

protected
