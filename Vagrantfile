Vagrant.configure("2") do |config|
    config.vm.box = "debian/jessie64"

    config.vm.provider "virtualbox" do |v|
        v.name = "coreos_builder"
        v.memory = 11264
        v.cpus = 4
    end

    config.vm.provision "shell", path: "provisioner.sh"
end