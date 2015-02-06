# -*- mode: ruby -*-
# vi: set ft=ruby :

$hostmanager = false

# Add Vagrant hostmanager plugin support if required
system 'vagrant plugin install vagrant-hostmananger' if $hostmanager unless Vagrant.has_plugin?('vagrant-hostmanager')
# Add VMWare Fusion support if required
system 'vagrant plugin install vmware_fusion' if ENV['VAGRANT_DEFAULT_PROVIDER'] == 'vmware_fusion' unless Vagrant.has_plugin?('vagrant-vmware-fusion')
system 'vagrant plugin install vmware_fusion' if ENV['VAGRANT_DEFAULT_PROVIDER'] == 'vmware_workstation' unless Vagrant.has_plugin?('vagrant-vmware-workstation')

system 'vagrant plugin install vagrant-berkshelf' unless Vagrant.has_plugin?('vagrant-berkshelf')
system 'vagrant plugin install vagrant-omnibus' unless Vagrant.has_plugin?('vagrant-omnibus')

Vagrant.require_version ">= 1.6.2"

Vagrant.configure("2") do |config|
#  config.vm.define = "windows_win81x64_packer"
  config.vm.box = "windows-8.1x64-enterprise"
  config.vm.communicator = :winrm

  # Admin user name and password
  config.winrm.username = "vagrant"
  config.winrm.password = "vagrant"

  config.vm.guest = :windows
  config.windows.halt_timeout = 30
  config.vm.boot_timeout = 300

  config.vm.network :forwarded_port, guest: 3389, host: 3389, id: "rdp", auto_correct: true
  config.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct: true
  config.vm.network :forwarded_port, guest: 22, host: 2222, id: "ssh", auto_correct: true

  ["vmware_fusion", "vmware_workstation"].each do |provider|
    config.vm.provider provider do |v, override|
      v.vmx["memsize"] = "1536"
      v.vmx["numvcpus"] = "1"
      v.vmx["ethernet0.virtualDev"] = "vmxnet3"
      v.vmx["RemoteDisplay.vnc.enabled"] = "true"
      v.vmx["RemoteDisplay.vnc.port"] = "5902"
      v.vmx["scsi0.virtualDev"] = "lsisas1068"
      v.vmx["gui.fitguestusingnativedisplayresolution"] = "FALSE"
      v.vmx["hypervisor.cpuid.v0"] = "FALSE"
    end
  end

  config.omnibus.chef_version = :latest
  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      chocolatey: {
        upgrade: 'true'
      }
    }

    chef.run_list = [
        "recipe[omnibus_updater_windows::default]",
        "recipe[windows-hyperv-packer-build-box::default]",
    ]
  end
end
