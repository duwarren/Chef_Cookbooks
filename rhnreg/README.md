spacewalk-client Cookbook
=========================
This cookbook installs and registers a node as a Spacewalk client.

Requirements
------------
- CentOS/RHEL 5,6,7
- Ubuntu 12.04, 14.04 (in process)

Attributes
----------
```
default['spacewalk']['pkg_source_path'] = Chef::Config[:file_cache_path]
default['spacewalk']['rhel']['base_url'] = 'http://yum.spacewalkproject.org/2.2-client/RHEL'
default['spacewalk']['reg']['key'] = 'my_activation_key'
default['spacewalk']['reg']['server'] = 'http://spacewalk.example.com'
default['spacewalk']['enable_osad'] = false
```

Usage
-----
#### spacewalk-client::rhel
Include `spacewalk-client::rhel` in your node's `run_list` and set the default['spacewalk']['reg'] attributes.

#### spacewalk-client::ubuntu

License and Authors
-------------------
Authors: Duval Warren duvalwarren@gmail.com
