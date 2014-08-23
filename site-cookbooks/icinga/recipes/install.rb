::Chef::Recipe.send :include, Opscode::OpenSSL::Password
# include_recipe 'mysql::server'

case node["platform"]
when "debian"
  apt_repository "icinga2" do
    uri "http://packages.icinga.org/debian"
    distribution "icinga-wheezy"
    components ["main"]
    key "34410682"
    keyserver "pgp.mit.edu"
  end

  %w(icinga2 icinga-cgi icinga2-classicui nagios-plugins nagios-nrpe-plugin).each do |pkg|
    package pkg
  end
when "ubuntu"
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
end


file "/var/www/html/index.html" do
  content nil
end
