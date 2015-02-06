include_recipe 'chocolatey'
chocolatey 'pswindowsupdate'

powershell_script "WindowsUpdate" do
  code <<-EOH
    Get-WUInstall -MicrosoftUpdate -AcceptAll -AutoReboot
  EOH
  action :run
end
