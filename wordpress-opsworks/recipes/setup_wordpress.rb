directory node[:wordpress_opsworks][:app_dir]

wp_download_url = "https://wordpress.org/latest.tar.gz"
wp_dist_file = "/tmp/wp-latest.tar.gz"

remote_file wp_dist_file do
	source wp_download_url
end

bash "untar-wordpress-app" do
	cwd node[:wordpress_opsworks][:app_dir]
	code <<-EOH
	tar xf #{wp_dist_file} --strip=1
	EOH
end
