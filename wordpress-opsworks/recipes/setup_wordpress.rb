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

root_wp_config = "#{node[:wordpress_opsworks][:app_dir]}/wp-config.php"
template root_wp_config do
	source "wp-global-config.php.erb"
end

%w(
	wordpress-https-forwarded
).each do |p|

	patch_file = "#{p}.patch"
	tmp_patch = "/tmp/#{patch_file}"

	cookbook_file tmp_patch do
		source patch_file
	end

	bash "apply-local-patch-#{p}" do
		cwd node[:wordpress_opsworks][:app_dir]
		code <<-EOH
		patch -p1 < #{tmp_patch}
		EOH
	end
end
