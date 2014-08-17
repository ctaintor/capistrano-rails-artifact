# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "deploy_target" do |deploy_target|
    deploy_target.vm.box = "opscode_centos-6.3_chef-11.2.0.box"
    deploy_target.vm.box_url = "http://vagrant.internal.machines/opscode/opscode_centos-6.3_chef-11.2.0.box"
    deploy_target.vbguest.auto_update = false
    deploy_target.vm.provider "virtualbox" do |v|
      v.memory = 512
      v.cpus = 1
    end
    deploy_target.ssh.forward_agent = true
  end

end
