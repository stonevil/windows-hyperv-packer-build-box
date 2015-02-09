include_recipe 'chocolatey'
node['chocolatey']['packages'].each do |chocopack|
  chocolatey chocopack
end

directory "#{ENV['APPDATA']}/packer.d/plugins" do
  action :create
  recursive true
end

remote_file "#{ENV['APPDATA']}/packer.d/plugins/packer-builder-hyperv-iso.exe" do
  source "https://raw.githubusercontent.com/pbolduc/packer-hyperv/blob/dev/bin/packer-builder-hyperv-iso.exe"
  action :create_if_missing
end
remote_file "#{ENV['APPDATA']}/packer.d/plugins/packer-post-processor-vagrant.exe" do
  source "https://raw.githubusercontent.com/pbolduc/packer-hyperv/blob/dev/bin/packer-post-processor-vagrant.exe"
  action :create_if_missing
end
remote_file "#{ENV['APPDATA']}/packer.d/plugins/packer-provisioner-powershell.exe" do
  source "https://raw.githubusercontent.com/pbolduc/packer-hyperv/blob/dev/bin/packer-provisioner-powershell.exe"
  action :create_if_missing
end
