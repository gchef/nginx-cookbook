node[:nginx][:apps].each do |app_name, app_attributes|
  nginx_app app_name do
    access_log            app_attributes[:access_log]
    access_log_format     app_attributes[:access_log_format]
    action                app_attributes[:action]
    client_max_body_size  app_attributes[:client_max_body_size]
    custom_directives     app_attributes[:custom_directives]
    error_log             app_attributes[:error_log]
    error_log_format      app_attributes[:error_log_format]
    keepalive_timeout     app_attributes[:keepalive_timeout]
    listen                app_attributes[:listen]
    locations             app_attributes[:locations]
    public_path           app_attributes[:public_path]
    server_name           app_attributes[:server_name]
    try_files             app_attributes[:try_files]
    upstream_keepalive    app_attributes[:upstream_keepalive]
    upstreams             app_attributes[:upstreams]
  end
end
