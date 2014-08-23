apt_repository "fastd" do
  uri "http://repo.universe-factory.net/debian/"
  distribution 'sid'
  components ["main"]
  key "16EF3F64CB201D9C"
  keyserver "pgpkeys.mit.edu"
end

package "batman-adv-dkms"

execute "reload batman_adv" do
  command "modprobe -r batman-adv; modprobe batman-adv"
  action :nothing
end

bash "install right version of batman-adv" do
  code <<-EOF
dkms remove batman-adv/2013.4.0 --all
dkms --force install batman-adv/2013.4.0
  EOF
  not_if { File.exists?("/sys/module/batman_adv/version") && File.open("/sys/module/batman_adv/version").read =~ /^2013\.4\.0/ }
  notifies :run, "execute[reload batman_adv]", :immediately
end

ruby_block "load batman-adv module" do
  block do
    fe = Chef::Util::FileEdit.new("/etc/modules")
    fe.insert_line_if_no_match(/batman-adv/, 'batman-adv')
    fe.write_file
  end
end

execute "modprobe batman-adv"

ruby_block "load interfaces.d" do
  block do
    fe = Chef::Util::FileEdit.new("/etc/network/interfaces")
    fe.insert_line_if_no_match(/source/, 'source /etc/network/interfaces.d/*.cfg')
    fe.write_file
  end
end

directory "/etc/network/interfaces.d" do
  action :create
end

execute "ifup bat0" do
  action :nothing
end

template "/etc/network/interfaces.d/bat0.cfg" do
  source "bat0.cfg.erb"
  notifies :run, "execute[ifup bat0]", :immediately
end

package "bridge-utils"

execute "ifup br0" do
  action :nothing
end

template "/etc/network/interfaces.d/br0.cfg" do
  source "br0.cfg.erb"
  notifies :run, "execute[ifup br0]", :immediately
end
