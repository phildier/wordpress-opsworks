
# user-uploaded content
directory node[:wordpress_opsworks][:content_dir] do
	user "www-data"
	group "www-data"
end
