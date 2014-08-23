# node.default[:fastd][:secret] = "your_private_key_for_fastd"

node.default[:fastd][:vpn_name] = "mesh-vpn";
node.default[:fastd][:git][:url] = "https://github.com/FreiFunkMuenster/gateway-ffms.git"
node.default[:fastd][:git][:path] = "/var/gateway-git"
node.default[:fastd][:git][:peers_path] = "backbone"
node.default[:fastd][:bat0][:mac] = "de:ad:be:ef:43:12"

# node.default[:fastd][:br0][:address] = "10.43.0.12"
# node.default[:fastd][:br0][:netmask] = "255.255.0.0"
# node.default[:fastd][:br0][:address6] = "fd68:e2ea:a53::12"
# node.default[:fastd][:br0][:netmask] = "48"
