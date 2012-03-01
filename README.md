Installs nginx from package OR source code and sets up configuration handling similar to Debian's Apache2 scripts.

Requires
----
* apt (for nginx::source)
* build-essential (for nginx::source)

Platform
----
Debian or Ubuntu though may work where 'build-essential' works, but other
platforms are untested.

Apps
----
Take this SSL-only app being served by rainbows (perfect for evented Ruby
apps):

    :nginx => {
      :apps => {
        :myapp_ssl => {
          :server_port => 443,
          :server_name => "myapp.domain.com myapp.domain.com.local",
          :public_path => "/home/myapp/app/public",
          :custom_location_directives => [
            "proxy_set_header X-Forwarded-Proto https;"
          ],
          :upstream_servers => [
            "unix:/home/myapp/app/tmp/web.sock max_fails=2 fail_timeout=5s",
            "127.0.0.1:8080 fail_timeout=5s backup"
          ],
          :custom_directives => [
            "ssl on;",
            "ssl_certificate /var/certs/myapp.crt;",
            "ssl_certificate_key /var/certs/myapp.key;",
            "ssl_session_timeout 5m;"
          ]
        }
      }
    }

We are using both a UNIX socket for the upstream (significantly quicker than a
TCP one), and we're defining a backup TCP socket, just in case our UNIX one
fails. We're also denifing some custom directives for this app's server block.
[More nginx load balancing and reverse proxying
tips](http://spin.atomicobject.com/2012/02/28/load-balancing-and-reverse-proxying-with-nginx).
