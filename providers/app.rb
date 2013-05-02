action :add do
  template "#{node[:nginx][:dir]}/sites-available/#{new_resource.name}" do
    cookbook "nginx"
    source "proxy.conf.erb"
    owner "root"
    group "root"
    mode "0644"
    variables(
      :app => new_resource
    )
    notifies :reload, resources(:service => "nginx"), :delayed
  end

  nginx_site new_resource.name
end

action :delete do
  remove
end

action :remove do
  remove
end

def remove
  bash "Delete nginx vhosts & logs for #{new_resource.name}" do
    code "rm -f #{node[:nginx][:log_dir]}/#{new_resource.name}* #{node[:nginx][:dir]}/sites*/#{new_resource.name}"
    notifies :reload, resources(:service => "nginx"), :delayed
  end
end

def load_current_resource
  service "nginx" do
    supports :reload => true
  end
end
