node[:nginx][:apps].each do |app_name, app_attributes|
  nginx_app app_name do
    app_attributes.each do |attribute, value|
      instance_variable_set("@#{attribute}", value)
    end
  end
end
