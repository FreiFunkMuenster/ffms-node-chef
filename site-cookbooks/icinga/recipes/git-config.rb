service "icinga2" do
  action :nothing
end

package 'git-core'

# Delete localhost config
directory "/etc/icinga2/conf.d/hosts" do
  action :delete
  recursive true
end

# Append icinga config to include services path
ruby_block "Append services-ffms path to icinga config" do
  block do
    fe = Chef::Util::FileEdit.new("/etc/icinga2/icinga2.conf")
    fe.insert_line_if_no_match(node[:icinga][:git][:path], %Q|include_recursive "#{node[:icinga][:git][:path]}/#{node[:icinga][:git][:objects_path]}"|)
    fe.write_file
  end
end

# Clone git repository with icinga configuration
execute "clone gateway git for icinga" do
  command "git clone #{node[:icinga][:git][:url]} #{node[:icinga][:git][:path]}"
  not_if { Dir.exists? node[:icinga][:git][:path] }
  notifies :reload, "service[icinga2]", :delayed
end

# Reload icinga automatically
cron "reload icinga" do
  action :create
  minute "1"
  command %Q|cd #{node[:icinga][:git][:path]} && git pull && service icinga2 reload|
end

