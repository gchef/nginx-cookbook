node[:nginx][:apps].each do |app|
  nginx_app app[:name] do
    access_log            app[:access_log]
    access_log_format     app[:access_log_format]
    action                app[:action]
    client_max_body_size  app[:client_max_body_size]
    custom_directives     app[:custom_directives]
    error_log             app[:error_log]
    error_log_format      app[:error_log_format]
    keepalive_timeout     app[:keepalive_timeout]
    listen                app[:listen]
    locations             app[:locations]
    public_path           app[:public_path]
    server_name           app[:server_name]
    try_files             app[:try_files]
    upstream_keepalive    app[:upstream_keepalive]
    upstreams             app[:upstreams]
  end
end
