action :add do
  proxy_type = new_resource.unix_connection ? ".unix" : ".tcp"

  template "#{node.nginx.dir}/sites-available/#{new_resource.name}" do
    cookbook "nginx"
    source "#{new_resource.type}#{proxy_type}.app.conf.erb"
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

action :remove do
  nginx_site new_resource.name do
    action :disable
  end
end
