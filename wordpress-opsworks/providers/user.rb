use_inline_resources

include WordpressOpsworks

action :create do
	username = new_resource.name
	database = new_resource.database
	password = new_resource.password
	nicename = new_resource.nicename
	email = new_resource.email
	url = new_resource.url
	status = new_resource.status
	display_name = new_resource.display_name

	create_user(database,username,password,nicename,email,url,status,display_name)

end


private

def user_exists?(database,username)
	system "mysql -u root #{database} -e 'select user_login from wp_users' | egrep '^#{username}$'"
end

def create_user(database,username,password,nicename,email,url,status,display_name)
	auth_str = mysql_auth
	insert_statement = sprintf(
			"insert into wp_users (user_login,user_pass,user_nicename,user_email,user_url,user_status,display_name) values ('%s',MD5('%s'),'%s','%s','%s','%s','%s')",
			username,password,nicename,email,url,status,display_name
			)
	puts insert_statement
	if !user_exists?(database,username) then
		system "mysql #{auth_str} #{database} -e \"#{insert_statement}\""
	end
end
