platform = case node["platform"]
           when "ubuntu"
             "xUbuntu_14.04"
           when "debian"
             "Debian_7.0"
           end

apt_repository "alfred" do
  uri "http://download.opensuse.org/repositories/home:/fusselkater:/ffms/#{platform}/"
  components ["/"]
  key "95658490"
  keyserver "pgp.mit.edu"
end

package 'alfred' do
  action :install
end
