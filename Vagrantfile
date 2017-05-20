# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
    config.vm.define "master" do |master|
    master.vm.box = "ubuntu/trusty64"
    # master.memory = 1024
    # master.cpus=2
    # config.vm.network "forwarded_port", guest: 80 , host: 8080
    master.vm.network "private_network", ip: "192.168.50.4"
    master.vm.provision :ansible do |ansible|
      ansible.playbook = "ansible/playbook_master.yml"
    end
  end
    config.vm.define "slave" do |slave|
    slave.vm.box = "ubuntu/trusty64"
    # slave.memory = 1024
    # slave.cpus=2
    # config.vm.network "forwarded_port", guest: 80 , host: 8081
    slave.vm.network "private_network", ip: "192.168.50.5"
    slave.vm.provision :ansible do |ansible|
      ansible.playbook = "ansible/playbook_slave.yml"
    end
  end
end
