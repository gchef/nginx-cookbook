default[:nginx][:version]            = "1.0.5"

set[:nginx][:dir]                    = "/etc/nginx"
set[:nginx][:log_dir]                = "/var/log/nginx"
set[:nginx][:binary]                 = "/usr/sbin/nginx"

set[:nginx][:user]                   = "www-data"
default[:nginx][:worker_processes]   = cpu[:total]
default[:nginx][:pid]                = "/var/run/nginx.pid"

default[:nginx][:worker_connections] = 2048
default[:nginx][:multi_accept]       = "off"

default[:nginx][:keepalive_timeout]             = 65
default[:nginx][:types_hash_max_size]           = 2048
default[:nginx][:server_tokens]                 = "off"
default[:nginx][:server_names_hash_bucket_size] = 64
default[:nginx][:server_name_in_redirect]       = "off"

default[:nginx][:gzip]              = "on"
default[:nginx][:gzip_disable]      = "msie6"

default[:nginx][:gzip_vary]         = "on"
default[:nginx][:gzip_proxied]      = "any"
default[:nginx][:gzip_comp_level]   = 2
default[:nginx][:gzip_min_length]   = "1024"
default[:nginx][:gzip_buffers]      = "16 8k"
default[:nginx][:gzip_http_version] = "1.1"
default[:nginx][:gzip_types] = [      "text/plain",
                                      "text/html",
                                      "text/css",
                                      "text/javascript",
                                      "application/json",
                                      "application/x-javascript",
                                      "text/xml",
                                      "application/xml",
                                      "application/xml+rss"
                                ]
