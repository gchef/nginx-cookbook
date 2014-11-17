include_recipe "apt"

apt_repository "nginx" do
  uri             node[:nginx][:apt_uri]
  distribution    node[:nginx][:distribution]
  components      node[:nginx][:components]
  keyserver       node[:nginx][:apt_keyserver]
  key             node[:nginx][:apt_key]
  action :add
end

node[:nginx][:apt_packages].each do |nginx_package|
  package nginx_package do
    version "#{node[:nginx][:version]}*"
    options '--force-yes -o Dpkg::Options::="--force-confold"'
    only_if "[ $(dpkg -l #{nginx_package} 2>&1 | grep #{node[:nginx][:version]}.* | grep -c '^h[ic] ') = 0 ]"
  end
end

node[:nginx][:apt_packages].each do |nginx_package|
  bash "freeze #{nginx_package}" do
    code "echo #{nginx_package} hold | dpkg --set-selections"
    only_if "[ $(dpkg --get-selections | grep -c '#{nginx_package}\W*hold') = 0 ]"
  end
end

service "nginx" do
  supports :status => true, :restart => true, :reload => true
end

directory node[:nginx][:log_dir] do
  owner node[:nginx][:user]
  group node[:nginx][:group]
  mode "0755"
  action :create
end

%w{nxensite nxdissite}.each do |nxscript|
  template "/usr/sbin/#{nxscript}" do
    owner "root"
    group "root"
    mode "0755"
    backup false
  end
end

template "nginx.conf" do
  path "#{node[:nginx][:dir]}/nginx.conf"
  owner "root"
  group "root"
  mode "0644"
  backup false
  notifies :restart, resources(:service => "nginx"), :delayed
end

directory node[:nginx][:sites_common_dir] do
  owner "root"
  group "root"
  mode "0755"
  action :create
end


template "#{node[:nginx][:dir]}/sites-available/default" do
  source "default-site.erb"
  owner "root"
  group "root"
  mode "0644"
end

directory node[:nginx][:proxy_cache_dir] do
  owner node[:nginx][:user]
  group node[:nginx][:group]
  mode "0755"
  recursive true
  action :create
end

if node[:nginx][:proxy_cache].any?
  file "#{node[:nginx][:dir]}/conf.d/cache.conf" do
    owner "root"
    group "root"
    mode "0644"
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

if node.has_key?(:bootstrap)
  if node[:nginx][:logrotate][:manage]
    rotated_logs_permissions = "#{node[:nginx][:logrotate][:mode]} #{node[:nginx][:user]} #{node[:nginx][:group]}"

    bootstrap_logrotate "nginx" do
      rotate node[:nginx][:logrotate][:period]
      keep node[:nginx][:logrotate][:keep]
      permissions rotated_logs_permissions
      copytruncate node[:nginx][:logrotate][:copytruncate]
      sharedscripts node[:nginx][:logrotate][:sharedscripts]
      prerotate node[:nginx][:logrotate][:prerotate]
      postrotate node[:nginx][:logrotate][:postrotate]
    end
  else
    bootstrap_logrotate "nginx" do
      action :delete
    end
  end
else
  Chef::Log.error("https://github.com/gchef/bootstrap-cookbook is not available, if you want to configure nginx logrotation, you will need to do it through a different recipe")
end
