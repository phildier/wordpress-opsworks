# wordpress virtual hosts

directory node[:wordpress_opsworks][:virtual_dir]

service "apache2"

# set up the symlinked vhosts
node[:wordpress_opsworks][:vhosts].each do |name,vhost|
	docroot = "#{node[:wordpress_opsworks][:virtual_dir]}/#{name}"

	# TODO use this var in vhost provider
	db_name = "wp_#{name}"

	wordpress_opsworks_vhost name do
		docroot docroot
		source node[:wordpress_opsworks][:app_dir]
		notifies :reload, "service[apache2]", :delayed
		themes vhost[:themes] || node[:wordpress_opsworks][:default_themes]
		plugins vhost[:plugins] || node[:wordpress_opsworks][:default_plugins]
		debug vhost[:debug] || "false"
	end

	wordpress_opsworks_user "#{name}-admin" do
		name vhost[:admin_username] || "admin"
		database db_name
		password vhost[:admin_password] || "admin"
		role "administrator"
	end

	wordpress_opsworks_user "#{name}-editor" do
		name vhost[:editor_username] || "editor"
		database db_name
		password vhost[:editor_password] || "editor"
		role "editor"
	end

	wordpress_opsworks_options db_name do
		siteurl vhost[:siteurl] || "http://#{name}/wordpress/"
		home vhost[:home] || "http://#{name}/"
		blogname vhost[:blogname] || "Default Blog"
		blogdescription vhost[:blogdescription] || "Default settings.  Try updating the vhost in your stack json"
		users_can_register vhost[:users_can_register] || "1"
		admin_email vhost[:admin_email] || "admin@#{name}"
	end
	
end
