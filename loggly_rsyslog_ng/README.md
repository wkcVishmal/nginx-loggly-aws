Loggly rsyslog LWRP
================

* Provide LWRP for configuring rsyslog for use with [Loggly](http://loggly.com).
* This cookbook was built upon the work from an existing cookbook, https://github.com/kdaniels/loggly-rsyslog.

Migration to version 5
-------------------

* Recently I released version 5 of **loggly_rsyslog_ng** cookbook.
* Resourse attributes were changed, so cookbook that use
  loggly_rsyslog_ng resource should be amended correspondingly.
* Major change - loggly resource defines one file to log. If you don't
  like that send PRs/Issues at github.
* Please send issues at github if you have any problems with this version.
* Changes are in CHANGELOG file.

Requirements
------------

* Chef 11 or higher
*  **Ruby 2.0.0 or higher**
*  **rsyslog 5.6.x or higher** (rsyslog 5.6.x support will be
  deprecated soon in favour of rsyslog 7.6.x+)

Platform
--------
Tested against Debian 7

Usage
-----------------
```
loggly_rsyslog_ng 'mylog' do
  log_filename      '/var/log/myapp.log'
  loggly_token      'my_very_secret_token'
  loggly_tags        [ node.chef_environment ]
  rsyslog_selector   ':syslogtag, isequal, "mylog:"'
  rsyslog_tag        'mylog'
end
```

### Notes
**mylog** is a name of loggly's resource. It's recommended to choose uniq name for each log resource.

Resources
----------
### default

* `name` - resource name. Should be uniq. Used for generation uniq parameters inside loggly_rsyslog_ng provider.
* `log_filename` - log file full path. Resource will add monitoring of this exact file.
* `log_owner` - in case that logfile isn't exist yet - loggly_rsyslog_ng will create one with no content and `log_owner` owner.
* `log_group` - in case that logfile isn't exist yet - loggly_rsyslog_ng will create one with no content and `log_group` group.
* `loggly_token` - The Loggly token.
* `loggly_tls_certs_install` - should resource install loggly tls certificate or not. By default it's `true`.
* `loggly_tls_name` - file name for loggly tls certificate. by default it's `rsyslog.loggly.crt`.
* `loggly_tls_path` - path to loggly tls certificate. by default it's `/etc/rsyslog.d/keys/ca.d`.
* `loggly_tags` - A list of event tags to apply to a message (https://www.loggly.com/docs/tags/) (optional).
* `loggly_host` - Loggly host. by default it's: `logs-01.loggly.com`.
* `loggly_port` - Loggly port. by default it's 6514 if TLS enabled and 514 otherwise.
* `rsyslog_config` - rsyslog local file config name. By default it's `/etc/rsyslog.d/22-loggly-_name_.conf`.
* `rsyslog_install` - shoud resource install rsyslog or not. by default it's `true`.
* `rsyslog_tls_enable` - enable or disable TLS. by default it's `true`.
* `rsyslog_ruleset` - rsyslog ruleset. by default it's the same as `name`.
* `rsyslog_tag` - rsyslog tag. by default it's the same as `name`.
* `rsyslog_selector` - rsyslog selector. by default it's `*.*`.
* `rsyslog_imfile_module` - should resource enable imfile rsyslog module. by default it's `true`.

### tls

* `cert_name` - Certificate local file name. Should be specified. Name attribute.
* `cert_from_file` - If `true` gets loggly SSL certificates from cookbook `files` directory. if `false` download them from loggly website. by default it's `true`
* `cert_url` - Url to the loggly.com certificate
* `intermediate_cert_url` - Url to the intermediate certificate
* `cert_checksum` - Cchecksum of the loggly.com certificate
* `intermediate_cert_checksum` - Checksum of the intermediate certificate

# Tests

* This cookbook has Test Kitchen config to test chef-run with this LWRP for errors. No integration tests yet.
* The default .kitchen.yml assumes that you are testing using vagrant driver, you will need Vagrant and Virtualbox installed.

To run converge, execute command:

     kitchen converge

## Important! Secure attributes and integration testing
Cookbooks contains secure attributes, that shouldn't be exposed in the git repository.

To start Test Kitchen you should set these environment variables:

 * `LOGGLY_TOKEN` - Loggly API token.


License & Authors
-----------------
- Author: Matt Veitas <mveitas@gmail.com>
- Author: Kostiantyn Lysenko <gshaud@gmail.com>

```text
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
