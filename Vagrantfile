new_plugin_installed = false
%w(
  vagrant-cachier
  vagrant-vbguest
).each do |plugin|
  next if Vagrant.has_plugin?(plugin)
  puts "Missing plugin #{plugin}, installing..."
  `vagrant plugin install #{plugin}`
  new_plugin_installed = true
end
exec "vagrant #{ARGV.join(' ')}" if new_plugin_installed

BASE_PATH = '/vagrant/transervicos'
VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "debian/jessie64"

  config.vm.provision 'ansible' do |ansible|
    ansible.playbook = 'provisioning/playbook.yml'
    ansible.sudo = true
    ansible.verbose = 'vv'
  end

  config.vm.network :forwarded_port, guest: 8080, host: 8000, auto_correct: true
  config.vm.network :forwarded_port, guest: 9876, host: 9876, auto_correct: true
  config.vm.synced_folder '.', BASE_PATH

  config.cache.scope = :box if Vagrant.has_plugin?('vagrant-cachier')

  # config.vbguest.auto_update = false
  # config.vbguest.no_remote = true
end
