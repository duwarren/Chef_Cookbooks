#
# Cookbook Name:: httpd
# Recipe:: default_proxy
#
# Copyright 2014, nerdrevolution INC
#
# All rights reserved - Do Not Redistribute
#
# chef-repo/cookbooks/httpd/recipes/cluster_node.rb
#
# Install apache for ubuntu systems

package "httpd" do
  action :install
end

template "/etc/httpd/conf/httpd.conf" do
source "httpd.conf.erb"
  variables(
    port:   node['httpd']["port"]
  )
  mode "0644"
  notifies :restart, 'service[httpd]'
end

# Write out homepge, restart if changes
template "/var/www/html/index.html" do
  source "index.html.erb"
  variables(
    adjective: node['httpd']['adjective']
  )
  mode "0644"
  notifies :restart, 'service[httpd]'
end

#
# Start the httpd service
# Make sure the service starts on reboot
service "httpd" do
  action [:start, :enable]
  end
#
