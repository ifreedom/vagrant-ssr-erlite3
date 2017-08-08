# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/debian-7.11"

  config.vm.provision :shell, path: 'bootstrap.sh', keep_color: true
end
