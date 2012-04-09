actions :add, :remove

attribute :name,                  :kind_of => String,  :name_attribute => true
attribute :server_port,           :kind_of => Fixnum,  :default => 80
attribute :server_name,           :kind_of => String
attribute :public_path,           :kind_of => String,  :default => "/usr/share/nginx/www"
attribute :locations,             :kind_of => Array,   :default => []
attribute :upstream_servers,      :kind_of => Array,   :default => []
attribute :try_files,             :kind_of => Array,   :default => [] # $uri/index.html $uri "@#{@app.name}"
attribute :error_page,            :kind_of => String,  :default => "/500.html"
attribute :client_max_body_size,  :kind_of => String,  :default => "4G"
attribute :keepalive_timeout,     :kind_of => Fixnum,  :default => 10
attribute :custom_directives,     :kind_of => Array,   :default => []

def initialize(*args)
  super
  @action = :add
end
