raise "Please set node[:icinga][:admin_password]" unless node[:icinga] && node[:icinga][:admin_password]

bash 'createpasswd' do
  user 'root'
  code %Q|/usr/bin/htpasswd -cb /etc/icinga2/classicui/htpasswd.users icingaadmin #{node[:icinga][:admin_password]}|
end

firewall_rule "icinga" do
  port 80
  action :allow
end
