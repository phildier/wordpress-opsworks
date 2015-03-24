# wordpress virtual hosts

directory node[:wordpress_opsworks][:virtual_dir]

# set up the symlinked vhosts
node[:wordpress_opsworks][:vhosts].each do |name,vhost|
	docroot = "#{node[:wordpress_opsworks][:virtual_dir]}/#{name}"

	# TODO use this var in vhost provider
	db_name = "wp_#{name}"

	wordpress_opsworks_vhost name do
		docroot docroot
		source node[:wordpress_opsworks][:app_dir]
		notifies :reload, "service[apache2]", :delayed
	end

	wordpress_opsworks_user "admin" do
		database db_name
		password "admin"
	end
	
end
