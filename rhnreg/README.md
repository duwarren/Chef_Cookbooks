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
default['spacewalk']['reg']['key1'] = ''
default['spacewalk']['reg']['key2'] = ''
default['spacewalk']['reg']['key3'] = ''
default['spacewalk']['reg']['key4'] = ''
default['spacewalk']['reg']['key5'] = ''
default['spacewalk']['reg']['key6'] = ''
default['spacewalk']['reg']['key7'] = ''
default['spacewalk']['reg']['key8'] = ''
default['spacewalk']['reg']['key9'] = ''
default['spacewalk']['reg']['server1'] = ''
default['spacewalk']['reg']['server2'] = ''
default['spacewalk']['reg']['node1'] = ''
default['spacewalk']['reg']['node2'] = ''
default['spacewalk']['reg']['server'] = 'http://spacewalk.example.com'
default['spacewalk']['enable_osad'] = false
```

Usage
-----
#### spacewalk-client::rhel
Include `rhnreg::default` in your node's `run_list` and set the default['spacewalk']['reg'] attributes.
You will need to add sshpass credentials for spacewalk server to remove form base channel and re-register
system with production channel 
#### spacewalk-client::ubuntu

License and Authors
-------------------
Authors: Duval Warren duvalwarren@gmail.com
