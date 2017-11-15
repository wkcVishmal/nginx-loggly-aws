#
# Cookbook Name:: loggly_rsyslog_ng
# Resource:: tls
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

actions :create, :remove 
default_action :create

attribute :cert_name, :kind_of => [String], :name_attribute => true, :required => true
attribute :cert_path, :kind_of => [String], :default => '/etc/rsyslog.d/keys/ca.d'
attribute :cert_from_file, :kind_of => [TrueClass, FalseClass], :default => true
attribute :cookbook, :kind_of => [String], :default => 'loggly_rsyslog_ng'
attribute :source, :kind_of => [String, NilClass], :default => 'rsyslog.loggly.crt'
attribute :cert_url, :kind_of => [String], :default => 'https://logdog.loggly.com/media/logs-01.loggly.com_sha12.crt'
