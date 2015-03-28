use_inline_resources

include WordpressOpsworks
require 'shellwords'

action :create do
	username = new_resource.name
	database = new_resource.database
	password = new_resource.password
	nicename = new_resource.nicename
	email = new_resource.email
	url = new_resource.url
	status = new_resource.status
	display_name = new_resource.display_name
	role = new_resource.role
	level = new_resource.level

	user_id = create_user(database,username,password,nicename,email,url,status,display_name)
	set_user_meta(database,user_id,'wp_capabilities','a:1:{s:13:"%s";b:1;}' % [role])
	set_user_meta(database,user_id,'wp_user_level',level)
end


private

def user_exists?(database,username)
	system "mysql -u root #{database} -e 'select user_login from wp_users' | egrep '^#{username}$'"
end

def create_user(database,username,password,nicename,email,url,status,display_name)
	insert_statement = sprintf(
			"insert into wp_users (user_login,user_pass,user_nicename,user_email,user_url,user_status,display_name) values ('%s',MD5('%s'),'%s','%s','%s','%s','%s')",
			username,password,nicename,email,url,status,display_name
			)
	if ! user_exists?(database,username)
		system "mysql #{mysql_auth} #{database} -e \"#{insert_statement}\""
	end

	# return user id
	`mysql #{mysql_auth} #{database} -e "select ID from wp_users where user_login='#{username}'" | tail -n1`.strip
end

def set_user_meta(database,user_id,meta_key,meta_value)
	insert_statement = "INSERT IGNORE INTO wp_usermeta (user_id,meta_key,meta_value) VALUES ('%s','%s','%s')" % [user_id,meta_key,meta_value]
	system "mysql #{mysql_auth} #{database} -e "+Shellwords.escape(insert_statement)
end
