# Cheatsheet

| Purpose                       | Command or action                                                                                              | Description                     |
|-------------------------------|----------------------------------------------------------------------------------------------------------------|---------------------------------|
| Password **root** account     |                                                                                                                | No                              |
| Password **vagrant** account  |                                                                                                                | `vagrant`, has sudo permisssion |
| Public network with static IP | Edit VagrantFile, add this line `config.vm.network "public_network", ip: "10.62.0.7", netmask:"255.255.255.0"` |                                 |

# Tips and Notes

1. Each Vagrant profile/VM should be stored in a independent directory, for example: `/vagrant/vm1`, `vagrant/vm2`.

2. To install python virtual environment inside a synced folder using option `--always-copy`: `virtualenv myproject/.venv --always-copy`