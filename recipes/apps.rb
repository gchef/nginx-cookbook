node[:nginx][:apps].each do |app_name, app_attributes|
  nginx_app app_name do
    type                  app_attributes[:type]
    upstream              app_attributes[:upstream]
    unix_connection       app_attributes[:unix_connection]
    tcp_connection        app_attributes[:tcp_connection]
    domains               app_attributes[:domains]
    public_path           app_attributes[:public_path]
    action                app_attributes[:action]
  end
end
