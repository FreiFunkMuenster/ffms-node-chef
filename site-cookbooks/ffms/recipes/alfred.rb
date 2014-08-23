apt_repository "alfred" do
  uri "http://download.opensuse.org/repositories/home:/fusselkater:/ffms/xUbuntu_14.04/"
  components ["/"]
  key "95658490"
  keyserver "pgp.mit.edu"
end

package 'alfred' do
  action :install
end
