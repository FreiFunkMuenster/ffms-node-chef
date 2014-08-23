::Chef::Recipe.send :include, Opscode::OpenSSL::Password
# include_recipe 'mysql::server'

apt_repository "icinga2" do
  uri "http://ppa.launchpad.net/formorer/icinga/ubuntu/"
  distribution "trusty"
  components ["main"]
  key "36862847"
  keyserver "keyserver.ubuntu.com"
end

%w(icinga2 icinga2-classicui nagios-plugins nagios-nrpe-plugin).each do |pkg|
  package pkg
end

file "/var/www/html/index.html" do
  content nil
end
