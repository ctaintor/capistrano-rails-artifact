# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "deploy_target" do |deploy_target|
    deploy_target.vm.box = "CentOS-6.5-x86_64-v20140504.box"
    deploy_target.vm.box_url = "https://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.5-x86_64-v20140504.box"
    deploy_target.vbguest.auto_update = false
    deploy_target.vm.provider "virtualbox" do |v|
      v.memory = 512
      v.cpus = 1
    end
    script = <<BLOCK
#These things are provided by a Chef-provisioned environment
#Creates a simple http server to server the files in '/vagrant/test'
cd /vagrant/test;
nohup python -m SimpleHTTPServer 8080 >/dev/null 2>&1 &
sleep 5
BLOCK
    deploy_target.vm.provision "shell", inline: script
    deploy_target.ssh.forward_agent = true
  end

end
