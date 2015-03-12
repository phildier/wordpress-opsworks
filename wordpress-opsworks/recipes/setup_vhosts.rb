# wordpress virtual hosts

directory node[:wordpress_opsworks][:virtual_dir]

# set up the symlinked vhosts
node[:wordpress_opsworks][:vhosts].each do |name,vhost|
	docroot = "#{node[:wordpress_opsworks][:virtual_dir]}/#{name}"

	wordpress_opsworks_vhost name do
		docroot docroot
		source node[:wordpress_opsworks][:app_dir]
		notifies :reload, "service[apache2]", :delayed
	end
	
end
