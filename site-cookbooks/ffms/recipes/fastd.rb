%w(fastd git-core).each do |pkg|
  package pkg
end

directory "/etc/fastd/vpn" do
  action :create
  recursive true
end

service "fastd" do
  action :start
end

template "/etc/fastd/vpn/fastd.conf" do
  source "fastd.conf.erb"
  notifies :restart, "service[fastd]", :delayed
end

if node[:fastd][:secret]
  file "/etc/fastd/vpn/secret.conf" do
    content %Q|secret "#{node[:fastd][:secret]}";|
    mode 00600
    owner 'root'
    group 'root'
    notifies :restart, "service[fastd]", :delayed
  end
else
  file "/etc/fastd/vpn/secret.conf" do
    mode 00600
    owner 'root'
    group 'root'
  end

  bash "generate fastd key" do
    # Generate a key
    code <<-EOF
      key=$(fastd --generate-key --machine-readable)
      echo "secret \\"$key\\";" > /etc/fastd/vpn/secret.conf
    EOF

    not_if { File.exists? "/etc/fastd/vpn/secret.conf" }
    notifies :restart, "service[fastd]", :delayed
  end
end

execute "clone gateway git" do
  command "git clone #{node[:fastd][:git][:url]} #{node[:fastd][:git][:path]}"
  not_if { Dir.exists? node[:fastd][:git][:path] }
  notifies :restart, "service[fastd]", :delayed
end

cron "reload fastd" do
  action :create
  minute "0"
  command %Q|cd #{node[:fastd][:git][:path]} && git pull && kill -HUP $(pidof fastd)|
end
