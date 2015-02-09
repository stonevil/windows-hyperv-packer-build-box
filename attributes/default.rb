if node['platform_family'] == 'windows'
  default['chocolatey']['Uri'] = 'https://chocolatey.org/install.ps1'
  default['chocolatey']['upgrade'] = true
end

default['chocolatey']['packages'] = %w(sysinternals 7zip vim git git.commandline git.install git-credential-winstore dotpeek wget make cmake golang packer chefdk)
