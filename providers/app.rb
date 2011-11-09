action :add do
  template "#{node[:nginx][:dir]}/sites-available/#{new_resource.name}" do
    cookbook "nginx"
    source "app.conf.erb"
    owner "root"
    group "root"
    mode "0644"
    variables(
      :app => new_resource
    )
  end

  nginx_site new_resource.name
end

action :remove do
  nginx_site new_resource.name do
    action :disable
  end
end
