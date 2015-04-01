include_recipe "apache2"

directory node[:wordpress_opsworks][:cache_dir]

# user-uploaded content
directory node[:wordpress_opsworks][:user_dir] do
	user "www-data"
	group "www-data"
end
