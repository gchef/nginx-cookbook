service "nginx"

template "#{node[:nginx][:dir]}/conf.d/status.conf" do
  owner "root"
  group "root"
  mode 0644
  backup false
  notifies :restart, resources(:service => "nginx"), :delayed
end

bash "Add nginx_status to hosts" do
  code %{
    match="nginx_status"
    string="127.0.0.1 $match"
    file=/etc/hosts

    if [ $(grep -c $match $file) = 0 ]; then
      echo "$string" >> $file
    else
      sed -i "s/.*$match.*/$string/g" $file
    fi
  }
end
