if node[:nginx][:disable_favicon_logging]
  cookbook_file "#{node[:nginx][:sites_common_dir]}/disable_favicon_logging.conf" do
    cookbook "nginx"
    owner "root"
    group "root"
    mode "0644"
    backup false
    notifies :restart, resources(:service => "nginx"), :delayed
  end
end

if node[:nginx][:disable_robots_logging]
  cookbook_file "#{node[:nginx][:sites_common_dir]}/disable_robots_logging.conf" do
    cookbook "nginx"
    owner "root"
    group "root"
    mode "0644"
    backup false
    notifies :restart, resources(:service => "nginx"), :delayed
  end
end

if node[:nginx][:disable_hidden]
  cookbook_file "#{node[:nginx][:sites_common_dir]}/disable_hidden.conf" do
    cookbook "nginx"
    owner "root"
    group "root"
    mode "0644"
    backup false
    notifies :restart, resources(:service => "nginx"), :delayed
  end
end
