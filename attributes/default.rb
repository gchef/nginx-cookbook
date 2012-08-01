default[:nginx][:version]              = "1.2.1*"

default[:nginx][:dir]                  = "/etc/nginx"
default[:nginx][:log_dir]              = "/var/log/nginx"
default[:nginx][:binary]               = "/usr/sbin/nginx"

default[:nginx][:user]                 = "www-data"

# A worker process is a single-threaded process.
#
# If Nginx is doing CPU-intensive work such as SSL or gzipping and you have 2
# or more CPUs/cores, then you may set worker_processes to be equal to the
# number of CPUs or cores.
#
# 1If you are serving a lot of static files and the total size of the files is
# bigger than the available memory, then you may increase worker_processes to
# fully utilize disk bandwidth.
#
# Your OS may schedule all workers on single CPU/core this can be avoided using
# worker_cpu_affinity.
#
# Nginx has the ability to use more than one worker process for several
# reasons:
#   * to use SMP
#   * to decrease latency when workers blockend on disk I/O
#   * to limit number of connections per process when select()/poll() is used
#
# The worker_processes and worker_connections from the event sections allows
# you to calculate maxclients value:
#
#   max_clients = worker_processes * worker_connections
#
default[:nginx][:worker_processes]     = cpu[:total]
#
# The worker_connections and worker_processes from the main section allows you
# to calculate max clients you can handle:
#
#   max clients = worker_processes * worker_connections
#
# In a reverse proxy situation, max clients becomes
#
#   max clients = worker_processes * worker_connections/4
# Since a browser opens 2 connections by default to a server and nginx uses the
# fds (file descriptors) from the same pool to connect to the upstream backend,
default[:nginx][:worker_connections]   = 1024
#
# Specifies the value for maximum file descriptors that can be opened by this
# process.
default[:nginx][:worker_rlimit_nofile] = 1024
default[:nginx][:pid]                  = "/var/run/nginx.pid"

default[:nginx][:multi_accept]         = "off"

# Directive sets the read timeout for the request body from client. The timeout
# is set only if a body is not get in one readstep. If after this time the
# client send nothing, nginx returns error "Request time out" (408). You may
# want to lower this value to protect yourself from attacks like Slowloris DoS
# attack explained lower on this page.
default[:nginx][:client_body_timeout] = 60
#
# Directive assigns timeout with reading of the title of the request of client.
# The timeout is set only if a header is not get in one readstep. If after this
# time the client send nothing, nginx returns error "Request time out" (408).
# Just like stated before, this value can be lowered to help mitigating attacks
# like the Slowloris DoS attack explained lower on this page.
default[:nginx][:client_header_timeout] = 60
#
# The first parameter assigns the timeout for keep-alive connections with the
# client. The server will close connections after this time.
#
# The optional second parameter assigns the time value in the header
# Keep-Alive: timeout=time of the response. This header can convince some
# browsers to close the connection, so that the server does not have to.
# Without this parameter, nginx does not send a Keep-Alive header (though this
# is not what makes a connection "keep-alive").
#
# The parameters can differ from each other.
#
# Notes on how browsers handle the Keep-Alive header:
#   * MSIE and Opera ignore the "Keep-Alive: timeout=<N>" header.
#   * MSIE keeps the connection alive for about 60-65 seconds, then sends a TCP RST.
#   * Opera keeps the connection alive for a long time.
#   * Mozilla keeps the connection alive for N plus about 1-10 seconds.
#   * Konqueror keeps the connection alive for about N seconds.
#
#   Every browser, and every version of each browser, has a
#   different timeout the use for keep alives. Firewalls also have their own
#   connection timeouts which may be shorter then the keep alives set on either
#   the client or server. This means browsers, servers and firewalls all have
#   to be in alignment so that keeps alives work. If not, the browser will try
#   to request something over a connection which will never work which results
#   in pausing and slowness for the user. Goolge Chrome got around this timeout
#   issue by sending a keepalive every 45 seconds until the browser's default
#   300 second timeout limit.
default[:nginx][:keepalive_timeout] = 75
#
# Directive assigns response timeout to client. Timeout is established not on
# entire transfer of answer, but only between two operations of reading, if
# after this time client will take nothing, then nginx is shutting down the
# connection. You may want to look at lowering this value if you have malicious
# clients opening connection and not closing them like in the Slowloris DoS
# attack explained lower on this page.
default[:nginx][:send_timeout] = 60
#
# The ignore_invalid_headers directive will drop any client trying to send
# invalid headers to the server. If you do not expect to receive any custom
# made headers then make sure to enable this option.
default[:nginx][:ignore_invalid_headers] = "off"

default[:nginx][:types_hash_max_size]           = 2048
default[:nginx][:server_tokens]                 = "off"
default[:nginx][:server_names_hash_bucket_size] = 64
default[:nginx][:server_name_in_redirect]       = "off"

default[:nginx][:gzip]              = "on"
default[:nginx][:gzip_disable]      = "msie6"

default[:nginx][:gzip_vary]         = "on"
default[:nginx][:gzip_proxied]      = "any"
default[:nginx][:gzip_comp_level]   = 6
default[:nginx][:gzip_buffers]      = "16 8k"
default[:nginx][:gzip_http_version] = "1.1"
default[:nginx][:gzip_min_length]   = "1024"

default[:nginx][:gzip_types] = [  "text/plain",
                                  "text/css",
                                  "application/json",
                                  "application/x-javascript",
                                  "text/xml",
                                  "application/xml",
                                  "application/xml+rss",
                                  "text/javascript"
                                ]

default[:nginx][:default] = "off"
default[:nginx][:https]   = "on"

# Enables default site
#
default[:nginx][:default_site] = true
default[:nginx][:apps]         = {}

# Status
#
default[:nginx][:status][:allow] = "127.0.0.1"
default[:nginx][:status][:deny]  = "all"

# Proxy cache, available globally
default[:nginx][:proxy_cache_dir] = "/usr/share/nginx/cache"
default[:nginx][:proxy_cache] = []
