#
# Cookbook Name:: nginx
# Recipe:: source
# Author:: Gerhard Lazu <gerhard@lazu.co.uk>
#
# Copyright 2011, Gerhard Lazu
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
#

include_recipe "build-essential"

package "libpcre3"
package "libpcre3-dev"
package "libssl-dev"

node.set[:nginx][:install_path]    = "/opt/nginx-#{node[:nginx][:version]}"
node.set[:nginx][:binary]      = "#{node[:nginx][:install_path]}/sbin/nginx"
configure_flags = [
  "--prefix=#{node[:nginx][:install_path]}",
  "--conf-path=#{node[:nginx][:dir]}/nginx.conf",
  "--with-http_ssl_module",
  "--with-http_gzip_static_module"
].join(" ")

remote_file "/usr/local/src/nginx-#{node[:nginx][:version]}.tar.gz" do
  source "http://sysoev.ru/nginx/nginx-#{node[:nginx][:version]}.tar.gz"
  action :create_if_missing
end

bash "compile_nginx_source" do
  cwd "/usr/local/src"
  code <<-EOH
    tar zxf nginx-#{node[:nginx][:version]}.tar.gz
    cd nginx-#{node[:nginx][:version]} && ./configure #{configure_flags}
    make && make install
  EOH
  creates node[:nginx][:binary]
  notifies :restart, resources(:service => "nginx")
end

service "nginx" do
  supports :status => true, :restart => true, :reload => true
  action :enable
end

directory node[:nginx][:log_dir] do
  mode 0755
  owner node[:nginx][:user]
  action :create
end

directory node[:nginx][:dir] do
  owner "root"
  group "root"
  mode "0755"
end

template "/etc/init.d/nginx" do
  source "nginx.init.erb"
  owner "root"
  group "root"
  mode "0755"
end

%w{ sites-available sites-enabled conf.d }.each do |dir|
  directory "#{node[:nginx][:dir]}/#{dir}" do
    owner "root"
    group "root"
    mode "0755"
  end
end

%w{nxensite nxdissite}.each do |nxscript|
  template "/usr/sbin/#{nxscript}" do
    source "#{nxscript}.erb"
    mode "0755"
    owner "root"
    group "root"
  end
end

template "nginx.conf" do
  path "#{node[:nginx][:dir]}/nginx.conf"
  source "nginx.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, resources(:service => "nginx"), :immediately
end
