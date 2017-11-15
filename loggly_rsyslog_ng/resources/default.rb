#
# Cookbook Name:: loggly_rsyslog_ng
# Resource:: default
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

actions :install, :uninstall

default_action :install

attribute :name, :kind_of => [String, NilClass], :name_attribute => true, :required => true
attribute :loggly_token, :kind_of => [String, NilClass], :default => nil, :required => true
attribute :loggly_tls_certs_install, :kind_of => [TrueClass, FalseClass], :default => true
attribute :loggly_tls_name, :kind_of => [String, NilClass], :default => 'rsyslog.loggly.crt'
attribute :loggly_tls_path, :kind_of => [String], :default => '/etc/rsyslog.d/keys/ca.d'
attribute :loggly_tags, :kind_of => [Array], :default => []
attribute :loggly_host, :kind_of => [String], :default => 'logs-01.loggly.com'
attribute :loggly_port, :kind_of => [Integer, NilClass], :default => nil
attribute :rsyslog_config, :kind_of => [String, NilClass], :default => nil
attribute :rsyslog_install, :kind_of => [TrueClass, FalseClass], :default => true
attribute :rsyslog_tls_enable, :kind_of => [TrueClass, FalseClass], :default => true
attribute :rsyslog_bundled_tls_enable, :kind_of => [TrueClass, FalseClass], :default => false
attribute :rsyslog_ruleset, :kind_of => [String, NilClass], :default => nil
attribute :rsyslog_tag, :kind_of => [String, NilClass], :default => nil
attribute :rsyslog_selector, :kind_of => [String], :default => '*.*'
attribute :rsyslog_imfile_module, :kind_of => [TrueClass, FalseClass], :default => true
attribute :rsyslog_imfile_module_source, :kind_of => [String, NilClass], :default => nil
attribute :rsyslog_input_file_poll_interval, :kind_of => [Integer], :default => 10
attribute :log_filename, :kind_of => [String, NilClass], :default => nil, :required => true
attribute :log_owner, :kind_of => [String, NilClass], :default => 'root'
attribute :log_group, :kind_of => [String, NilClass], :default => 'root'
attribute :cookbook, :kind_of => [String], :default => 'loggly_rsyslog_ng'
attribute :source, :kind_of => [String, NilClass], :default => nil
