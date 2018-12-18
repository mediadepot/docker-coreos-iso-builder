Vagrant.configure("2") do |config|
    config.vm.box = "centos/7"
    config.vm.network "private_network", type: "dhcp"

    config.vm.provider "virtualbox" do |v|
        v.name = "coreos_builder"
        v.memory = 11264
        v.cpus = 4
    end


    config.vm.provision "shell", path: "provisioner.sh", env: {
        "GITHUB_RELEASE_REPO" => "mediadepot/vagrant-coreos-kernel-builder",
        "GITHUB_RELEASE_ID" => "14555587",
        "GITHUB_ACCESS_TOKEN" => ENV["GITHUB_ACCESS_TOKEN"]
    }
end