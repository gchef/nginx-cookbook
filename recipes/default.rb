require_recipe "apt"

apt_repository "nginx" do
  uri "http://ppa.launchpad.net/nginx/stable/ubuntu"
  keyserver "keyserver.ubuntu.com"
  key "C300EE8C"
  action :add
end

package "nginx" do
  version "#{node[:nginx][:version]}*"
end

directory node[:nginx][:log_dir] do
  owner node[:nginx][:user]
  group node[:nginx][:user]
  mode 0755
  action :create
end

%w{nxensite nxdissite}.each do |nxscript|
  template "/usr/sbin/#{nxscript}" do
    source "#{nxscript}.erb"
    owner "root"
    group "root"
    mode 0755
    backup false
  end
end

template "nginx.conf" do
  path "#{node[:nginx][:dir]}/nginx.conf"
  source "nginx.conf.erb"
  owner "root"
  group "root"
  mode 0644
  backup false
  notifies :restart, "service[nginx]"
end

template "#{node[:nginx][:dir]}/sites-available/default" do
  source "default-site.erb"
  owner "root"
  group "root"
  mode 0644
end

service "nginx" do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end

nginx_site "default" do
  action (node[:nginx][:default_site] ? :enable : :disable)
end
