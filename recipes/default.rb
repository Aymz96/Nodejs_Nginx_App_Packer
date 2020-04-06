#
# Cookbook:: nodejs_nginx
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

package 'nginx' do
  action [:install] # unintsall?
end

package 'nodejs'


service 'nginx' do
  action [:enable, :start]
end

template "/etc/nginx/sites-available/proxy.conf" do
  source 'proxy.conf.erb'
end
