use_inline_resources

include WordpressOpsworks

action :create do

	database = new_resource.database

	set_option(database,"siteurl",new_resource.siteurl)
	set_option(database,"home",new_resource.home)
	set_option(database,"blogname",new_resource.blogname)
	set_option(database,"blogdescription",new_resource.blogdescription)
	set_option(database,"users_can_register",new_resource.users_can_register)
	set_option(database,"admin_email",new_resource.admin_email)

end


private

def set_option(database,name,value)
	auth_str = mysql_auth
	# only set value if it's null (initial setup)
	update_statement = sprintf(
			"update wp_options set option_value='%s' where option_name='%s' and option_value='Uninitialized'",
			value.gsub(/\\/, '\&\&').gsub(/'/, "''"),
			name
			)
	system "mysql #{auth_str} #{database} -e \"#{update_statement}\""
end
