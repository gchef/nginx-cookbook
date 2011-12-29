template "#{node[:nginx][:dir]}/conf.d/status.conf" do
  owner "root"
  group "root"
  mode 0644
  backup false
  notifies :restart, "service[nginx]"
end
