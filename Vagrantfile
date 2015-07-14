# -*- mode: ruby -*-
# vi: set ft=ruby :

# set true to manage /etc/hosts in a multinode environment
manage_hosts = "true"

# comment out, add/remove boxes as necessary for testing
# Vagrant code will spin up whatever is configured in this block
#  :name - hostname
#  :box  - configured box name in Vagrant
#  :url  - url to obtain the box
#  :ip   - private ip of vm
#  :cpu  - cpu core count
#  :ram  - amount of memory
#  :role - vm role (if defined) - supported options are ansible-single, ansible-multi
#  fwd_guest_1 & :fwd_host_1 - first pair of ports forwarded, guest/host respectively
#  fwd_guest_2 & :fwd_host_2 - first pair of ports forwarded, guest/host respectively

boxes = [
  {
    :name => "bg",
    :box => "trusty64",
    :url => "https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vbox.box",
    :ip => '192.168.50.11',
    :cpu => "2",
    :ram => "2048",
    :fwd_guest_1 => "80",
    :fwd_host_1 => "8888"
   },
]

############################
# End Vagrant guest config #
############################

Vagrant.configure("2") do |config|
  boxes.each do |box|
    config.vm.define box[:name] do |node|
      node.vm.box = box[:box]
      node.vm.box_url = box[:url]
      node.vm.provider :virtualbox do |v, override|
        v.customize ["modifyvm", :id, "--memory", box[:ram]]
        v.customize ["modifyvm", :id, "--cpus", box[:cpu]]
        v.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
        v.customize ["modifyvm", :id, "--chipset", "ich9"]
        v.customize ["modifyvm", :id, "--largepages", "on"]
        v.customize ["modifyvm", :id, "--vtxvpid", "on"]
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--ioapic", "on"]
      end
      node.vm.network :private_network, ip: box[:ip]
      node.vm.hostname = box[:name]

      # Ansible provisioner.
      config.vm.provision "ansible" do |ansible|
        ansible.playbook = "playbook.yml"
        ansible.host_key_checking = false
        ansible.verbose = "vvv"
      end

      # Setup vm specific port forwards
      if box[:fwd_guest_1]
        node.vm.network "forwarded_port", guest: box[:fwd_guest_1], host: box[:fwd_host_1]
      end
      if box[:fwd_guest_2]
        node.vm.network "forwarded_port", guest: box[:fwd_guest_2], host: box[:fwd_host_2]
      end
    end

    # Configure /etc/hosts on each node
    if manage_hosts == 'true'
      config.vm.provision "shell", inline: "echo $1 $2 >> /etc/hosts", args: [box[:ip], box[:name]]
    end
  end
end
