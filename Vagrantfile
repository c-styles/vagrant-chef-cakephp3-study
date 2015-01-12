# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
Vagrant.require_version ">= 1.7.0"

#Require Plugins
unless Vagrant.has_plugin?("vagrant-vbguest")
  raise 'vagrant-vbguest is not installed!'
end
unless Vagrant.has_plugin?("vagrant-hostsupdater")
  raise 'vagrant-hostsupdater is not installed!'
end
unless Vagrant.has_plugin?("vagrant-berkshelf")
  raise 'vagrant-berkshelf is not installed!'
end
#Recommend Plugins
unless Vagrant.has_plugin?("vagrant-cachier")
  puts 'vagrant-cachier is not installed.'
end

Vagrant.configure(2) do |config|
  if Vagrant.has_plugin?("vagrant-hostsupdater")
    config.hostsupdater.remove_on_suspend = true
  end
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  config.vm.box = "ubuntu/precise64"
  config.vm.hostname = "app.example.com"
  config.vm.network :private_network, ip: "192.168.10.10" #IP設定
  config.vm.synced_folder "./", "/vagrant", disabled: true #デフォルトの共有フォルダ設定を止める

  #VirtualBox設定
  config.vm.provider "virtualbox" do |vb|
    #vb.gui = true # Display the VirtualBox GUI when booting the machine
    # Customize the amount of memory on the VM:
    vb.cpus = "2"
    vb.memory = "1024"
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "80"]
  end

    config.berkshelf.enabled = true #Vagrant Bekshelfを利用する
    config.vm.provision "chef_zero" do |chef|
      chef.install = true
      chef.version = "11.10"
      chef.log_level = "debug"
      # Specify the local paths where Chef data is stored
      chef.cookbooks_path = "cookbooks"
      chef.roles_path = "roles"
      chef.nodes_path = "nodes"
      chef.data_bags_path = "data_bags"
      # Add a recipe
      #chef.add_recipe "awscli"
      chef.add_recipe "chef-solo-search"
      chef.add_recipe "users"
      chef.add_recipe "users::sysadmins"
      chef.add_recipe "vagrant-chef-cakephp3-study::mysql-server"
      chef.json = {
        "mysqld" => {
          "root_password" => "password"
        }
      }
# Or maybe a role
#    chef.add_role "web"
  end

end
