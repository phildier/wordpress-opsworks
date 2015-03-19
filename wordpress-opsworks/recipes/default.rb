include_recipe "apache2"

directory node[:wordpress_opsworks][:cache_dir]

# user-uploaded content
directory node[:wordpress_opsworks][:content_dir] do
	user "www-data"
	group "www-data"
end
