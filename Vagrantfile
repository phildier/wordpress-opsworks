VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

	config.vm.box = "ubuntu1204-opsworks"
	config.vm.box_url = "http://raven-opensource.s3.amazonaws.com/ubuntu1204-opsworks.box"
	config.vm.network :private_network, ip: "10.49.0.10"
	config.vm.network :forwarded_port, guest: 8000, host: 8080

	overrides = JSON.parse(IO.read(File.dirname(__FILE__)+"/overrides.json"))

	# check for vhosts with "shared" attribute and mount them
	overrides["deploy"].each do |app,vhost|
		if vhost.key?("shared") then
			config.vm.synced_folder vhost["shared"], 
				"/srv/www/#{app}/current", 
				type: "nfs"
		end
	end

	# arbitrary shared directories
	if overrides.key?("shared") then
		overrides["shared"].each do |name,shared|
			if shared.key? "host_dir" then
				config.vm.synced_folder shared["host_dir"],
					shared["guest_dir"],
					type: "nfs"
			end
		end
	end

	config.vm.provision :shell, path: "scripts/vagrant_bootstrap.sh"

	config.vm.provision :chef_solo do |chef|
		chef.cookbooks_path = [".","berks-cookbooks"]
		chef.roles_path = "."
		chef.add_role "vagrant"
		chef.json = overrides
	end

	config.vm.provider :virtualbox do |vb|
		vb.customize ["modifyvm", :id, "--rtcuseutc", "on", "--memory", "2048", "--cpus", "2", "--natdnshostresolver1", "on"]
	end

end

