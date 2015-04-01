
directory node[:wordpress_opsworks][:cache_dir]

# user-uploaded content
directory node[:wordpress_opsworks][:user_dir] do
	user "www-data"
	group "www-data"
end

package "mysql-client-5.5"

s3_file "#{node[:wordpress_opsworks][:cache_dir]}/#{node[:wordpress_opsworks][:mysql][:schema_file]}" do
	remote_path node[:wordpress_opsworks][:mysql][:schema_file]
	bucket node[:wordpress_opsworks][:s3][:bucket]
	if node[:wordpress_opsworks][:s3][:id] then
		aws_access_key_id node[:wordpress_opsworks][:s3][:id] 
	end
	if node[:wordpress_opsworks][:s3][:key] then
		aws_secret_access_key node[:wordpress_opsworks][:s3][:key] 
	end
end
