module WordpressOpsworks

	# cli auth parameters
	def mysql_auth
		if ! node[:wordpress_opsworks][:mysql][:password].empty?
			pw = "-p'#{node[:wordpress_opsworks][:mysql][:password] }'"
		end
		"-h #{node[:wordpress_opsworks][:mysql][:host]} -u #{node[:wordpress_opsworks][:mysql][:username]} #{pw}"
	end

end
