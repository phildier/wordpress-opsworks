use_inline_resources

include WordpressOpsworks

action :create do
    db_name = new_resource.name
    siteurl = new_resource.siteurl
    home = new_resource.home
	database_file = new_resource.database_file

	if create_db(db_name)
		if import_db(db_name,database_file)
			true
		else 
			raise "couldn't import database #{db_name}"
		end
	else
		raise "couldn't create database #{db_name}"
	end

end


private

def database_exists?(database)
	system("mysql #{mysql_auth} -e 'SHOW DATABASES' | egrep -e '^#{database}$'")
end

def database_empty?(database)
	system("mysql #{mysql_auth} #{database} -e 'SHOW TABLES' | egrep 'options'") ? false : true
end

# creates database if it doesn't exist
def create_db(db_name)
	if ! database_exists?(db_name)
		execute "mysqladmin #{mysql_auth} create #{db_name}"
	else
		true
	end
end

# import schema if db is empty
def import_db(db_name,database_file)
	if database_empty?(db_name)
		execute "bunzip2 -c #{database_file} | mysql #{mysql_auth} #{db_name}"
	else
		true
	end
end
