Vagrant.configure("2") do |config|
    config.vm.box = "centos/7"
    config.vm.network "private_network", type: "dhcp"

    config.vm.provider "virtualbox" do |v|
        v.name = "coreos_builder"
        v.memory = 11264
        v.cpus = 4
    end


    config.vm.provision "shell", path: "provisioner.sh", env: {
        "GCP_CREDENTIALS_GS_REFRESH_TOKEN" => ENV["GCP_CREDENTIALS_GS_REFRESH_TOKEN"],
        "GCP_GSUTIL_PROJECT_ID" => "mediadepot",
        "GCP_GSUTIL_BUCKET_ID" => "mediadepot-coreos"
    }
end