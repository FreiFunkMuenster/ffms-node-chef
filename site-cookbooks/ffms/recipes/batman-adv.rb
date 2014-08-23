apt_repository "fastd" do
  uri "http://repo.universe-factory.net/debian/"
  distribution 'sid'
  components ["main"]
  key "16EF3F64CB201D9C"
  keyserver "pgpkeys.mit.edu"
end

package "batman-adv-dkms"

ruby_block "load batman-adv module" do
  block do
    fe = Chef::Util::FileEdit.new("/etc/modules")
    fe.insert_line_if_no_match(/batman-adv/, 'batman-adv')
    fe.write_file
  end
end

execute "modprobe batman-adv"

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
