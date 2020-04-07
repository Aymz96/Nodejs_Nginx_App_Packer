
# Cookbook:: nodejs_nginx
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

apt_update 'update_sources' do
  action :update
end

package 'nginx'


service 'nginx' do
  action [:enable, :start]
end

# creating template in machine
template "/etc/nginx/sites-available/proxy.conf" do
  source 'proxy.conf.erb'
  notifies :restart, 'service[nginx]'
end

# making symbolic link to obove template
link '/etc/nginx/sites-enabled/proxy.conf' do
  to '/etc/nginx/sites-available/proxy.conf'
  notifies :restart, 'service[nginx]'
end


link '/etc/nginx/sites-enabled/default' do
  action :delete
  notifies :restart, 'service[nginx]'
end


include_recipe 'nodejs'
# Does not install npm by default. Sad :(
# include_recipe "nodejs::npm"
# try installing npm using package
# package 'npm'

npm_package 'pm2'
npm_package 'react'
