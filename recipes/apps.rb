node[:nginx][:apps].each do |app_name, app_attributes|
  nginx_app app_name do
    server_port           app_attributes[:server_port]
    server_name           app_attributes[:server_name]
    public_path           app_attributes[:public_path]
    locations             app_attributes[:locations]
    upstream_servers      app_attributes[:upstream_servers]
    upstream_keepalive    app_attributes[:upstream_keepalive]
    try_files             app_attributes[:try_files]
    error_page            app_attributes[:error_page]
    client_max_body_size  app_attributes[:client_max_body_size]
    keepalive_timeout     app_attributes[:keepalive_timeout]
    custom_directives     app_attributes[:custom_directives]
    action                app_attributes[:action]
  end
end
