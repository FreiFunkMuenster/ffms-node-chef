firewall_rule "ssh" do
  port 22
  action :allow
end

firewall "ufw" do
  action :enable
end
