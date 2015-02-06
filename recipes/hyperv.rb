include_recipe 'windows'
windows_feature 'Microsoft-Hyper-V /All' do
  action :install
  notifies :request, 'windows_reboot[60]'
end
