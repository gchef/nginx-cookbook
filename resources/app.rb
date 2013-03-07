actions :add, :remove
default_action :add

# http://wiki.nginx.org/HttpLogModule
attribute :access_log,            :kind_of => String,  :default => ""
attribute :access_log_format,     :kind_of => String,  :default => "default"

# http://wiki.nginx.org/NginxCoreModule#error_log
attribute :error_log,             :kind_of => String,  :default => ""
attribute :error_log_format,      :kind_of => String,  :default => "crit" # debug | info | notice | warn | error | crit | alert | emerg

attribute :client_max_body_size,  :kind_of => String,  :default => "16M"
attribute :custom_directives,     :kind_of => Array,   :default => []
attribute :keepalive_timeout,     :kind_of => Fixnum,  :default => 10
attribute :listen,                :kind_of => Array,   :default => [80]
attribute :locations,             :kind_of => Array,   :default => []
attribute :name,                  :kind_of => String,  :name_attribute => true
attribute :public_path,           :kind_of => String
attribute :server_name,           :kind_of => String
attribute :try_files,             :kind_of => Array,   :default => [] # $uri/index.html $uri "@#{@app.name}"
attribute :upstream_keepalive,    :kind_of => Fixnum,  :default => 4
attribute :upstreams,             :kind_of => Array,   :default => []

def access_log_path
  if access_log.empty?
    "#{node[:nginx][:log_dir]}/#{name}.access.log"
  else
    access_log
  end
end

def error_log_path
  if error_log.empty?
    "#{node[:nginx][:log_dir]}/#{name}.error.log"
  else
    error_log
  end
end
