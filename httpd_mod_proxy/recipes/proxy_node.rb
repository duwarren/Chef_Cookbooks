#
# Cookbook Name:: httpd
# Recipe:: proxy_node
#
# Copyright 2014, nerdrevolution INC
#
# All rights reserved - Do Not Redistribute
#
# chef-repo/cookbooks/httpd/recipes/proxy_node.rb
#

package "haproxy" do
  action :install
end
package "openssl-devel" do
  action :install
end
template "/etc/haproxy/haproxy.cfg" do
  source "haproxy.cfg.erb"
  mode "0644"
  variables ({ 
    cluster_nodes: node['httpd']['cluster_nodes']
  })
  notifies :restart, 'service[haproxy]'
end
#
# Start the apache service
# Make sure the service starts on reboot
service "haproxy" do
  action [ :start, :enable ]
end
