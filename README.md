Installs nginx from package OR source code and sets up configuration handling similar to Debian's Apache2 scripts.

Requires
----
* apt (for nginx::source)
* build-essential (for nginx::source)

Platform
----
Debian or Ubuntu though may work where 'build-essential' works, but other platforms are untested.

Apps
----
Take this app being served by rainbows (works great for evented Ruby apps):

    :nginx => {
      :apps => {
        :app_name => {
          :upstream => "rainbows",
          :upstream_connection => "localhost:8080 max_fails=3 fail_timeout=1s",
          :domains => "app_name.domain app_name.domain.alias",
          :public_path => "/home/ruby_app/current/public"
        }
      }

Upstream can also be a Unix socket, doesn't have to be a TCP one.
