Vagrant.configure("2") do |config|
    config.vm.box = "centos/7"
    config.vm.network "private_network", type: "dhcp"

    config.vm.provider "virtualbox" do |v|
        v.name = "coreos_builder"
        v.memory = 16384
        v.cpus = 6
    end

    # # create the gsutil config file. Make sure it is created outside of the CHROOT (before cork create). It'll be parsed and a .boto file will be created in the chroot.
    config.vm.provision "file", source: "~/.config/gcloud/application_default_credentials.json", destination: "/home/vagrant/.config/gcloud/application_default_credentials.json"

    config.vm.provision "shell", path: "provisioner.sh"
end