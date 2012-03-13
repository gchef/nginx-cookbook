require_recipe "apt"

apt_repository "nginx" do
  uri "http://ppa.launchpad.net/nginx/stable/ubuntu"
  keyserver "keyserver.ubuntu.com"
  key "C300EE8C"
  action :add
end

package "nginx"

service "nginx"

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
  notifies :restart, resources(:service => "nginx"), :delayed
end

template "#{node[:nginx][:dir]}/sites-available/default" do
  source "default-site.erb"
  owner "root"
  group "root"
  mode 0644
end

if node[:nginx][:proxy_cache].any?
  file "#{node[:nginx][:dir]}/conf.d/cache.conf" do
    owner "root"
    group "root"
    mode 0644
    content(
      node[:nginx][:proxy_cache].join("\n")
    )
    backup false
    notifies :restart, resources(:service => "nginx"), :delayed
  end
end

service "nginx" do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end

nginx_site "default" do
  action (node[:nginx][:default_site] ? :enable : :disable)
end
