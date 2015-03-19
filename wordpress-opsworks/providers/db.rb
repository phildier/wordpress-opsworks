use_inline_resources

action :create do
    db_name = new_resource.name
    siteurl = new_resource.siteurl
    home = new_resource.home
    admin_username = new_resource.admin_username
    admin_password = new_resource.admin_password
	database_file = new_resource.database_file

	if create_db(db_name)
		if import_db(db_name,database_file)

		else 
			raise "couldn't import database #{db_name}"
		end
	else
		raise "couldn't create database #{db_name}"
	end

end


private

# creates database if it doesn't exist
def create_db(db_name)
	auth_str = mysql_auth
	execute "mysqladmin #{auth_str} create #{db_name}" do
		not_if { system("mysql #{auth_str} -e 'SHOW DATABASES' | egrep -e '^#{db_name}$'") }
	end
end

# import database
def import_db(db_name,database_file)
	auth_str = mysql_auth
	execute "bunzip2 -c #{database_file} | mysql #{auth_str} #{db_name}" do
		not_if { system("mysql #{auth_str} -e 'SHOW TABLES' | egrep -e 'options'") }
	end
end

# cli auth parameters
def mysql_auth
	if ! node[:wordpress_opsworks][:mysql][:password].empty?
		pw = "-p'#{node[:wordpress_opsworks][:mysql][:password] }'"
	end
	"-h #{node[:wordpress_opsworks][:mysql][:host]} -u #{node[:wordpress_opsworks][:mysql][:username]} #{pw}"
end
