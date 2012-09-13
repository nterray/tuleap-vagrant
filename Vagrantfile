# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "centos5_8"

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  # config.vm.network :hostonly, "192.168.33.10"
  config.vm.network :hostonly, '10.11.13.11'

  # Assign this VM to a bridged network, allowing you to connect directly to a
  # network using the host's network device. This makes the VM appear as another
  # physical device on your network.
  # config.vm.network :bridged

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  # config.vm.forward_port 80, 8080

  # Assuming the following layout:
  # 
  #   tuleap
  #   ├── manifest
  #   ├── tuleap
  #   └── vagrant
  #
  # The root "tuleap" folder will be available as /mnt/tuleap in the VM.
  # NFS is prefered over VirtualBox shared folders, because it is faster.
  config.vm.share_folder 'v-tuleap',
                         '/mnt/tuleap',
                         '..',
                         :nfs => true
  
  config.nfs.map_uid = Process.uid
  config.nfs.map_gid = Process.gid

  config.vm.provision :chef_solo do |chef|
    chef.log_level = :debug
    
    chef.cookbooks_path = 'cookbooks'
    chef.roles_path     = 'roles'
    chef.data_bags_path = 'data_bags'
    
    # chef.add_role 'tuleap'
    chef.add_role 'tuleap_packaging'
    # chef.add_recipe 'tuleap::build'
    
    chef.json = {:tuleap => {
      :yum_repo => 'local',
      :php_base => 'php53',
      # :centos_mirror => 'ftp://degaine.cro.enalean.com/ftp.centos.org/5.8',
      # :development   => {:uid   => config.nfs.map_uid,
      #                    :gid   => config.nfs.map_gid}
    }}
  end
end
