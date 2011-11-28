node[:nginx][:apps].each do |app_name, app_attributes|
  nginx_app app_name do
    type                  app_attributes[:type]
    upstream              app_attributes[:upstream]
    upstream_connection   app_attributes[:upstream_connection]
    domains               app_attributes[:domains]
    public_path           app_attributes[:public_path]
    action                app_attributes[:action]
    notifies              :restart, resources(:service => "nginx"), :delayed
  end
end
