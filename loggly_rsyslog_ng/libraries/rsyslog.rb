#
# Cookbook Name:: loggly_rsyslog_ng
# Library:: rsyslog
#
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

module RSyslog
  def self.version_76_plus?
    Gem::Version.new(get_version) > Gem::Version.new('7.6.0')
  end

  def self.get_version
    cmd = Mixlib::ShellOut.new('rsyslogd -version')
    cmd.run_command
    unless cmd.error?      
      cmd.stdout[/rsyslogd\ ([\d\.]*)/,1]
    else
      nil
    end
  end
end
