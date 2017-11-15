#
# Cookbook Name:: loggly_rsyslog_ng
# Provider:: tls
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

action :create do

  cert_path = new_resource.cert_path

  directory cert_path do
    owner 'root'
    group 'root'
    mode 0755
    action :create
    recursive true
  end

  if new_resource.cert_from_file
    cookbook_file "#{new_resource.cert_path}/#{new_resource.cert_name}" do
      cookbook new_resource.cookbook
      source new_resource.source
    end
  else
    remote_file 'Download loggly.com cert' do
      owner 'root'
      group 'root'
      mode 0644
      use_conditional_get true
      path "#{new_resource.cert_path}/#{new_resource.cert_name}"
      source new_resource.cert_url
    end
  end
end

action :remove do
  file "#{new_resource.cert_path}/#{new_resource.cert_name}" do
    action :delete
    ignore_failure true
  end
end

protected
