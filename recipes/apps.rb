node[:nginx][:apps].each do |app_name, app_attributes|
  nginx_app app_name do
    server_port                 app_attributes[:server_port]
    server_name                 app_attributes[:server_name]
    public_path                 app_attributes[:public_path]
    access_control              app_attributes[:access_control]
    custom_location_directives  app_attributes[:custom_location_directives]
    proxy_type                  app_attributes[:proxy_type]
    upstream_servers            app_attributes[:upstream_servers]
    custom_directives           app_attributes[:custom_directives]
    action                      app_attributes[:action]
  end
end
