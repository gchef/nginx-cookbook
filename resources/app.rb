actions :add, :remove

attribute :name,                        :kind_of => String,  :name_attribute => true
attribute :server_port,                 :kind_of => Fixnum,  :default => 80
attribute :server_name,                 :kind_of => String
attribute :public_path,                 :kind_of => String,  :default => "/usr/share/nginx/www"
attribute :access_control,              :kind_of => Array,   :default => []
attribute :custom_location_directives,  :kind_of => Array,   :default => []
attribute :proxy_type,                  :kind_of => String,  :default => "proxy_pass",           :equal_to => %w[proxy_pass uwsgi_pass]
attribute :upstream_servers,            :kind_of => Array,   :default => []
attribute :custom_directives,           :kind_of => Array,   :default => []

def initialize(*args)
  super
  @action = :add
end
